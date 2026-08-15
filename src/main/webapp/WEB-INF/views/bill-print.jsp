<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bill APT-${appointment.id} | Sunrise Dental</title>
  <%@ include file="/WEB-INF/views/partials/head.jsp" %>
  <style>
    /* When printing (or "Save as PDF" from the print dialog), hide everything
       except the receipt itself - no buttons, no back link. */
    @media print {
      .no-print { display: none !important; }
      body { background: white !important; }
      #receipt { box-shadow: none !important; border: none !important; }
    }
  </style>
</head>

<%-- Standalone page: no sidebar/header, so printing only outputs the receipt. --%>
<body class="bg-gray-100 min-h-screen py-10 px-4">

  <%-- Action bar (not printed) --%>
  <div class="no-print max-w-2xl mx-auto mb-4 flex items-center justify-between">
    <a href="${pageContext.request.contextPath}/appointments/view?id=${appointment.id}"
       class="inline-flex items-center gap-1 text-sm text-slate-500 hover:text-slate-700">
      <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19.5 7.5 12l7.5-7.5"/></svg>
      Back to appointment
    </a>
    <button type="button" onclick="window.print()"
            class="flex items-center gap-2 px-4 py-2 rounded-lg bg-blue-600 text-white text-sm font-medium hover:bg-blue-700">
      <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6.75 6.75V4.5a1.5 1.5 0 0 1 1.5-1.5h7.5a1.5 1.5 0 0 1 1.5 1.5v2.25M6.75 17.25H5.25a1.5 1.5 0 0 1-1.5-1.5v-6a1.5 1.5 0 0 1 1.5-1.5h13.5a1.5 1.5 0 0 1 1.5 1.5v6a1.5 1.5 0 0 1-1.5 1.5h-1.5M6.75 14.25h10.5v6a.75.75 0 0 1-.75.75H7.5a.75.75 0 0 1-.75-.75v-6Z"/></svg>
      Print / Save as PDF
    </button>
  </div>

  <%-- ===== The receipt itself ===== --%>
  <div id="receipt" class="max-w-2xl mx-auto bg-white rounded-xl shadow-sm border border-gray-200 p-8">

    <%-- Clinic header --%>
    <div class="flex items-center justify-between border-b border-gray-200 pb-6 mb-6">
      <div class="flex items-center gap-3">
        <img src="${pageContext.request.contextPath}/assets/logo-bg.png" alt="Sunrise Dental Clinic" class="h-12 w-12 rounded-lg object-cover"/>
        <div>
          <p class="text-lg font-bold text-slate-800 leading-tight">Sunrise Dental Clinic</p>
          <p class="text-xs text-slate-400">Trincomalee &middot; 011 234 5678</p>
        </div>
      </div>
      <div class="text-right">
        <p class="text-sm font-semibold text-slate-700">PATIENT BILL</p>
        <p class="text-xs text-slate-400">Bill No: INV-${bill.id}</p>
        <p class="text-xs text-slate-400">Date: ${bill.generatedAt}</p>
      </div>
    </div>

    <%-- Patient + visit info, side by side --%>
    <div class="grid grid-cols-2 gap-6 mb-6 text-sm">
      <div>
        <p class="text-xs font-semibold text-slate-400 uppercase tracking-wide mb-2">Patient</p>
        <p class="font-medium text-slate-800">${appointment.patientName}</p>
        <p class="text-slate-500">${empty appointment.patientAddress ? '-' : appointment.patientAddress}</p>
        <p class="text-slate-500">${empty appointment.patientContact ? '-' : appointment.patientContact}</p>
      </div>
      <div>
        <p class="text-xs font-semibold text-slate-400 uppercase tracking-wide mb-2">Visit</p>
        <p class="font-medium text-slate-800">APT-${appointment.id}</p>
        <p class="text-slate-500">${appointment.appointmentDate} at ${appointment.appointmentTime}</p>
        <p class="text-slate-500">Dr. ${appointment.dentistName}<c:if test="${not empty appointment.dentistSpecialization}"> (${appointment.dentistSpecialization})</c:if></p>
      </div>
    </div>

    <%-- Itemized costs --%>
    <table class="w-full text-sm mb-2">
      <thead>
        <tr class="text-left text-slate-400 border-b border-gray-200">
          <th class="py-2 font-medium">Description</th>
          <th class="py-2 font-medium text-right">Amount (Rs.)</th>
        </tr>
      </thead>
      <tbody class="divide-y divide-gray-100">
        <tr>
          <td class="py-2.5 text-slate-700">Consultation Fee</td>
          <td class="py-2.5 text-right text-slate-700">${bill.consultationFee}</td>
        </tr>
        <tr>
          <td class="py-2.5 text-slate-700">Treatment &ndash; ${appointment.treatmentType}</td>
          <td class="py-2.5 text-right text-slate-700">${bill.treatmentAmount}</td>
        </tr>
        <%-- Only show the additional fees row if there is a charge, so a zero-fee bill stays clean. --%>
        <c:if test="${bill.additionalFees > 0}">
          <tr>
            <td class="py-2.5 text-slate-700">
              Additional Fees<c:if test="${not empty bill.additionalNotes}"> (${bill.additionalNotes})</c:if>
            </td>
            <td class="py-2.5 text-right text-slate-700">${bill.additionalFees}</td>
          </tr>
        </c:if>
      </tbody>
    </table>

    <%-- Total --%>
    <div class="flex items-center justify-between border-t-2 border-dashed border-gray-300 pt-3 mt-2">
      <span class="font-semibold text-slate-800">Total</span>
      <span class="text-xl font-bold text-slate-800">Rs. ${bill.totalAmount}</span>
    </div>

    <%-- Footer --%>
    <div class="mt-8 pt-6 border-t border-gray-100 text-center">
      <p class="text-sm text-slate-500">Thank you for visiting Sunrise Dental Clinic.</p>
      <p class="text-xs text-slate-400 mt-1">This is a computer-generated bill.</p>
    </div>
  </div>

</body>
</html>
