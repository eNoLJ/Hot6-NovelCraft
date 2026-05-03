package com.example.hot6novelcraft.domain.payment.service;

import com.example.hot6novelcraft.domain.payment.entity.Payment;
import com.example.hot6novelcraft.domain.payment.entity.enums.PaymentMethod;
import com.example.hot6novelcraft.domain.payment.entity.enums.PaymentStatus;
import com.example.hot6novelcraft.domain.payment.repository.PaymentRepository;
import io.portone.sdk.server.payment.CancelledPayment;
import io.portone.sdk.server.payment.FailedPayment;
import io.portone.sdk.server.payment.PaidPayment;
import io.portone.sdk.server.payment.PartialCancelledPayment;
import io.portone.sdk.server.payment.PaymentClient;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;

import java.util.Collections;
import java.util.List;
import java.util.concurrent.CompletableFuture;

import static org.mockito.ArgumentMatchers.*;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
@DisplayName("PaymentReconciliationService 테스트")
class PaymentReconciliationServiceTest {

    @InjectMocks
    private PaymentReconciliationService reconciliationService;

    @Mock
    private PaymentRepository paymentRepository;

    @Mock
    private PaymentTransactionService paymentTransactionService;

    @Mock
    private PaymentClient paymentClient;

    private static final Long PAYMENT_ID = 100L;
    private static final Long USER_ID = 1L;
    private static final Long AMOUNT = 10000L;
    private static final String PAYMENT_KEY = "payment-test-key-12345";

    private Payment createMockPayment(Long id, PaymentStatus status) {
        Payment payment = mock(Payment.class);
        given(payment.getId()).willReturn(id);
        given(payment.getUserId()).willReturn(USER_ID);
        given(payment.getAmount()).willReturn(AMOUNT);
        given(payment.getStatus()).willReturn(status);
        given(payment.getPaymentKey()).willReturn(PAYMENT_KEY);
        return payment;
    }

    // =========================================================
    // reconcile() - 재검증 대상 없을 때
    // =========================================================
    @Nested
    @DisplayName("reconcile() - 재검증 대상 없음")
    class ReconcileEmptyTest {

        @Test
        @DisplayName("PENDING, FAILED 대상 모두 없으면 포트원 API 미호출")
        void reconcile_noTargets_skipsPortOneCall() {
            // given
            given(paymentRepository.findByStatusAndCreatedAtBefore(eq(PaymentStatus.PENDING), any()))
                    .willReturn(Collections.emptyList());
            given(paymentRepository.findByStatusAndCreatedAtBetween(eq(PaymentStatus.FAILED), any(), any()))
                    .willReturn(Collections.emptyList());

            // when
            reconciliationService.reconcile();

            // then
            verify(paymentClient, never()).getPayment(anyString());
            verify(paymentTransactionService, never()).completePayment(anyLong(), anyLong(), anyLong(), any());
            verify(paymentTransactionService, never()).failPayment(anyLong());
        }
    }

    // =========================================================
    // reconcile() - PENDING 재검증
    // =========================================================
    @Nested
    @DisplayName("reconcile() - 스테일 PENDING 재검증")
    class ReconcileStalePendingTest {

        @Test
        @DisplayName("성공 - PENDING + PaidPayment → completePayment 호출")
        void reconcile_stalePending_portOnePaid_completesPayment() throws Exception {
            // given
            Payment payment = createMockPayment(PAYMENT_ID, PaymentStatus.PENDING);
            PaidPayment paidPayment = mock(PaidPayment.class);
            given(paidPayment.getMethod()).willReturn(mock(io.portone.sdk.server.payment.PaymentMethod.class));

            given(paymentRepository.findByStatusAndCreatedAtBefore(eq(PaymentStatus.PENDING), any()))
                    .willReturn(List.of(payment));
            given(paymentRepository.findByStatusAndCreatedAtBetween(eq(PaymentStatus.FAILED), any(), any()))
                    .willReturn(Collections.emptyList());
            given(paymentClient.getPayment(PAYMENT_KEY))
                    .willReturn(CompletableFuture.completedFuture(paidPayment));

            // when
            reconciliationService.reconcile();

            // then
            verify(paymentTransactionService, times(1))
                    .completePayment(eq(PAYMENT_ID), eq(USER_ID), eq(AMOUNT), any(PaymentMethod.class));
            verify(paymentTransactionService, never()).failPayment(anyLong());
        }

        @Test
        @DisplayName("성공 - PENDING + FailedPayment → failPayment 호출")
        void reconcile_stalePending_portOneFailed_failsPayment() throws Exception {
            // given
            Payment payment = createMockPayment(PAYMENT_ID, PaymentStatus.PENDING);
            FailedPayment failedPayment = mock(FailedPayment.class);

            given(paymentRepository.findByStatusAndCreatedAtBefore(eq(PaymentStatus.PENDING), any()))
                    .willReturn(List.of(payment));
            given(paymentRepository.findByStatusAndCreatedAtBetween(eq(PaymentStatus.FAILED), any(), any()))
                    .willReturn(Collections.emptyList());
            given(paymentClient.getPayment(PAYMENT_KEY))
                    .willReturn(CompletableFuture.completedFuture(failedPayment));

            // when
            reconciliationService.reconcile();

            // then
            verify(paymentTransactionService, times(1)).failPayment(PAYMENT_ID);
            verify(paymentTransactionService, never()).completePayment(anyLong(), anyLong(), anyLong(), any());
        }

        @Test
        @DisplayName("성공 - PENDING + CancelledPayment → failPayment 호출")
        void reconcile_stalePending_portOneCancelled_failsPayment() throws Exception {
            // given
            Payment payment = createMockPayment(PAYMENT_ID, PaymentStatus.PENDING);
            CancelledPayment cancelledPayment = mock(CancelledPayment.class);

            given(paymentRepository.findByStatusAndCreatedAtBefore(eq(PaymentStatus.PENDING), any()))
                    .willReturn(List.of(payment));
            given(paymentRepository.findByStatusAndCreatedAtBetween(eq(PaymentStatus.FAILED), any(), any()))
                    .willReturn(Collections.emptyList());
            given(paymentClient.getPayment(PAYMENT_KEY))
                    .willReturn(CompletableFuture.completedFuture(cancelledPayment));

            // when
            reconciliationService.reconcile();

            // then
            verify(paymentTransactionService, times(1)).failPayment(PAYMENT_ID);
        }

        @Test
        @DisplayName("성공 - PENDING + PartialCancelledPayment → failPayment 호출")
        void reconcile_stalePending_portOnePartialCancelled_failsPayment() throws Exception {
            // given
            Payment payment = createMockPayment(PAYMENT_ID, PaymentStatus.PENDING);
            PartialCancelledPayment partialCancelledPayment = mock(PartialCancelledPayment.class);

            given(paymentRepository.findByStatusAndCreatedAtBefore(eq(PaymentStatus.PENDING), any()))
                    .willReturn(List.of(payment));
            given(paymentRepository.findByStatusAndCreatedAtBetween(eq(PaymentStatus.FAILED), any(), any()))
                    .willReturn(Collections.emptyList());
            given(paymentClient.getPayment(PAYMENT_KEY))
                    .willReturn(CompletableFuture.completedFuture(partialCancelledPayment));

            // when
            reconciliationService.reconcile();

            // then
            verify(paymentTransactionService, times(1)).failPayment(PAYMENT_ID);
        }

        @Test
        @DisplayName("성공 - PENDING + 포트원도 PENDING 상태 (미확정) → 스킵")
        void reconcile_stalePending_portOneStillPending_skips() throws Exception {
            // given
            Payment payment = createMockPayment(PAYMENT_ID, PaymentStatus.PENDING);
            // PaidPayment, FailedPayment, CancelledPayment 중 어느 것도 아닌 상태
            io.portone.sdk.server.payment.Payment unknownStatePayment =
                    mock(io.portone.sdk.server.payment.Payment.class);

            given(paymentRepository.findByStatusAndCreatedAtBefore(eq(PaymentStatus.PENDING), any()))
                    .willReturn(List.of(payment));
            given(paymentRepository.findByStatusAndCreatedAtBetween(eq(PaymentStatus.FAILED), any(), any()))
                    .willReturn(Collections.emptyList());
            given(paymentClient.getPayment(PAYMENT_KEY))
                    .willReturn(CompletableFuture.completedFuture(unknownStatePayment));

            // when
            reconciliationService.reconcile();

            // then
            verify(paymentTransactionService, never()).completePayment(anyLong(), anyLong(), anyLong(), any());
            verify(paymentTransactionService, never()).failPayment(anyLong());
        }

        @Test
        @DisplayName("실패 - 포트원 API 예외 발생 시 해당 건 스킵 (다른 건 계속 처리)")
        void reconcile_portOneException_skipsFailedAndContinues() throws Exception {
            // given
            Payment failingPayment = createMockPayment(PAYMENT_ID, PaymentStatus.PENDING);
            Payment successPayment = createMockPayment(200L, PaymentStatus.PENDING);
            given(successPayment.getPaymentKey()).willReturn("payment-another-key");

            FailedPayment failedPayment = mock(FailedPayment.class);

            CompletableFuture<io.portone.sdk.server.payment.Payment> failedFuture = new CompletableFuture<>();
            failedFuture.completeExceptionally(new RuntimeException("PortOne API 오류"));

            given(paymentRepository.findByStatusAndCreatedAtBefore(eq(PaymentStatus.PENDING), any()))
                    .willReturn(List.of(failingPayment, successPayment));
            given(paymentRepository.findByStatusAndCreatedAtBetween(eq(PaymentStatus.FAILED), any(), any()))
                    .willReturn(Collections.emptyList());
            given(paymentClient.getPayment(PAYMENT_KEY)).willReturn(failedFuture);
            given(paymentClient.getPayment("payment-another-key"))
                    .willReturn(CompletableFuture.completedFuture(failedPayment));

            // when
            reconciliationService.reconcile();

            // then - 첫 번째 건 실패해도 두 번째 건은 처리됨
            verify(paymentTransactionService, times(1)).failPayment(200L);
            verify(paymentTransactionService, never()).failPayment(PAYMENT_ID);
        }
    }

    // =========================================================
    // reconcile() - 최근 FAILED 재검증
    // =========================================================
    @Nested
    @DisplayName("reconcile() - 최근 FAILED 재검증 (confirm 타임아웃 케이스)")
    class ReconcileRecentFailedTest {

        @Test
        @DisplayName("성공 - FAILED + PaidPayment → completePayment 호출 (confirm 타임아웃 복구)")
        void reconcile_recentFailed_portOnePaid_completesPayment() throws Exception {
            // given
            Payment payment = createMockPayment(PAYMENT_ID, PaymentStatus.FAILED);
            PaidPayment paidPayment = mock(PaidPayment.class);
            given(paidPayment.getMethod()).willReturn(mock(io.portone.sdk.server.payment.PaymentMethod.class));

            given(paymentRepository.findByStatusAndCreatedAtBefore(eq(PaymentStatus.PENDING), any()))
                    .willReturn(Collections.emptyList());
            given(paymentRepository.findByStatusAndCreatedAtBetween(eq(PaymentStatus.FAILED), any(), any()))
                    .willReturn(List.of(payment));
            given(paymentClient.getPayment(PAYMENT_KEY))
                    .willReturn(CompletableFuture.completedFuture(paidPayment));

            // when
            reconciliationService.reconcile();

            // then
            verify(paymentTransactionService, times(1))
                    .completePayment(eq(PAYMENT_ID), eq(USER_ID), eq(AMOUNT), any(PaymentMethod.class));
        }

        @Test
        @DisplayName("성공 - FAILED + FailedPayment → failPayment 호출 (정상 실패, 멱등성)")
        void reconcile_recentFailed_portOneAlsoFailed_callsFailPayment() throws Exception {
            // given
            Payment payment = createMockPayment(PAYMENT_ID, PaymentStatus.FAILED);
            FailedPayment failedPayment = mock(FailedPayment.class);

            given(paymentRepository.findByStatusAndCreatedAtBefore(eq(PaymentStatus.PENDING), any()))
                    .willReturn(Collections.emptyList());
            given(paymentRepository.findByStatusAndCreatedAtBetween(eq(PaymentStatus.FAILED), any(), any()))
                    .willReturn(List.of(payment));
            given(paymentClient.getPayment(PAYMENT_KEY))
                    .willReturn(CompletableFuture.completedFuture(failedPayment));

            // when
            reconciliationService.reconcile();

            // then - failPayment는 이미 FAILED면 내부에서 스킵되므로 부작용 없음
            verify(paymentTransactionService, times(1)).failPayment(PAYMENT_ID);
            verify(paymentTransactionService, never()).completePayment(anyLong(), anyLong(), anyLong(), any());
        }
    }

    // =========================================================
    // reconcile() - 복수 건 처리
    // =========================================================
    @Nested
    @DisplayName("reconcile() - 복수 건 동시 처리")
    class ReconcileMultipleTest {

        @Test
        @DisplayName("검증 - PENDING, FAILED 각각 독립적으로 처리")
        void reconcile_multiplePayments_allProcessed() throws Exception {
            // given
            Payment pendingPayment = createMockPayment(PAYMENT_ID, PaymentStatus.PENDING);
            Payment failedPayment = createMockPayment(200L, PaymentStatus.FAILED);
            given(failedPayment.getPaymentKey()).willReturn("payment-failed-key");

            PaidPayment paidPayment1 = mock(PaidPayment.class);
            given(paidPayment1.getMethod()).willReturn(mock(io.portone.sdk.server.payment.PaymentMethod.class));
            PaidPayment paidPayment2 = mock(PaidPayment.class);
            given(paidPayment2.getMethod()).willReturn(mock(io.portone.sdk.server.payment.PaymentMethod.class));

            given(paymentRepository.findByStatusAndCreatedAtBefore(eq(PaymentStatus.PENDING), any()))
                    .willReturn(List.of(pendingPayment));
            given(paymentRepository.findByStatusAndCreatedAtBetween(eq(PaymentStatus.FAILED), any(), any()))
                    .willReturn(List.of(failedPayment));
            given(paymentClient.getPayment(PAYMENT_KEY))
                    .willReturn(CompletableFuture.completedFuture(paidPayment1));
            given(paymentClient.getPayment("payment-failed-key"))
                    .willReturn(CompletableFuture.completedFuture(paidPayment2));

            // when
            reconciliationService.reconcile();

            // then
            verify(paymentTransactionService, times(1))
                    .completePayment(eq(PAYMENT_ID), anyLong(), anyLong(), any());
            verify(paymentTransactionService, times(1))
                    .completePayment(eq(200L), anyLong(), anyLong(), any());
        }
    }
}
