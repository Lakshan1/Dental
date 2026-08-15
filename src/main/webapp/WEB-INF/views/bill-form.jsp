<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bill for APT-${appointment.id} | Sunrise Dental</title>
  <%@ include file="/WEB-INF/views/partials/head.jsp" %>
</head>

<body class="bg-gray-50 text-slate-700">

  <div class="flex h-screen overflow-hidden">

    <c:set var="active" value="appointments" />
    <%@ include file="/WEB-INF/views/partials/sidebar.jsp" %>

    <div class="flex-1 flex flex-col overflow-hidden">

      <jsp:include page="/WEB-INF/views/partials/header.jsp">
        <jsp:param name="pageTitle" value="Appointments"/>
        <jsp:param name="pageSubtitle" value="Generate bill"/>
      </jsp:include>

      <main class="flex-1 overflow-y-auto p-6">

        <a href="${pageContext.request.contextPath}/appointments/view?id=${appointment.id}"
           class="inline-flex items-center gap-1 text-sm text-slate-500 hover:text-slate-700 mb-4">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19.5 7.5 12l7.5-7.5"/></svg>
          Back to appointment
        </a>

        <div class="max-w-xl">
          <h2 class="text-2xl font-bold text-slate-800 mb-1">
            <c:choose><c:when test="${not empty bill}">Update Bill</c:when><c:otherwise>Generate Bill</c:otherwise></c:choose>
            for APT-${appointment.id}
          </h2>
          <p class="text-sm text-slate-400 mb-6">Patient: <span class="font-medium text-slate-600">${appointment.patientName}</span> &middot; Dentist: <span class="font-medium text-slate-600">${appointment.dentistName}</span></p>

          <c:if test="${not empty error}">
            <div class="mb-4 px-4 py-3 rounded-lg bg-rose-50 border border-rose-100 text-sm text-rose-700">${error}</div>
          </c:if>

          <form action="${pageContext.request.contextPath}/appointments/bill" method="post"
                class="bg-white rounded-xl border border-gray-200 p-6 space-y-5">

            <input type="hidden" name="id" value="${appointment.id}"/>

            <%-- Consultation fee: fixed, comes from the dentist's profile, not editable here. --%>
            <div>
              <label class="block text-sm font-medium text-slate-700 mb-1">Consultation Fee</label>
              <div class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-200 bg-gray-50 text-slate-600">
                Rs. <span id="consultationFeeDisplay">${appointment.consultationFee}</span>
              </div>
              <p class="text-xs text-slate-400 mt-1">Set on the dentist's profile.</p>
            </div>

            <%-- Treatment amount --%>
            <div>
              <label class="block text-sm font-medium text-slate-700 mb-1">Treatment Amount (${appointment.treatmentType})</label>
              <input type="number" id="treatmentAmount" name="treatmentAmount" min="0" step="0.01" required
                     value="${not empty param.treatmentAmount ? param.treatmentAmount : bill.treatmentAmount}"
                     oninput="updateTotal()"
                     class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none"/>
            </div>

            <%-- Additional fees + a note describing what they're for --%>
            <div>
              <label class="block text-sm font-medium text-slate-700 mb-1">Additional Fees</label>
              <input type="number" id="additionalFees" name="additionalFees" min="0" step="0.01"
                     value="${not empty param.additionalFees ? param.additionalFees : (empty bill ? 0 : bill.additionalFees)}"
                     oninput="updateTotal()"
                     class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none"/>
              <input type="text" name="additionalNotes"
                     value="${not empty param.additionalNotes ? param.additionalNotes : bill.additionalNotes}"
                     placeholder="What are the additional fees for? (e.g. medication, X-ray) - optional"
                     class="mt-2 w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none"/>
            </div>

            <%-- Live total preview --%>
            <div class="flex items-center justify-between px-4 py-3 rounded-lg bg-blue-50 border border-blue-100">
              <span class="text-sm font-medium text-blue-700">Estimated Total</span>
              <span class="text-lg font-bold text-blue-700">Rs. <span id="totalDisplay">0.00</span></span>
            </div>

            <div class="flex items-center justify-end gap-3 pt-2">
              <a href="${pageContext.request.contextPath}/appointments/view?id=${appointment.id}"
                 class="px-4 py-2 rounded-lg border border-gray-300 text-sm font-medium text-slate-600 hover:bg-gray-50">Cancel</a>
              <button type="submit" class="px-4 py-2 rounded-lg bg-emerald-600 text-white text-sm font-medium hover:bg-emerald-700">Save &amp; View Bill</button>
            </div>
          </form>
        </div>

      </main>
    </div>
  </div>

  <script>
    var CONSULTATION_FEE = ${appointment.consultationFee};

    // Recalculate the estimated total as the staff member types.
    function updateTotal() {
      var treatment = parseFloat(document.getElementById('treatmentAmount').value) || 0;
      var additional = parseFloat(document.getElementById('additionalFees').value) || 0;
      var total = CONSULTATION_FEE + treatment + additional;
      document.getElementById('totalDisplay').textContent = total.toFixed(2);
    }
    window.addEventListener('DOMContentLoaded', updateTotal);
  </script>
</body>
</html>
