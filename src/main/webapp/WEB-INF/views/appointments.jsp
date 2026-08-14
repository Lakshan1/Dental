<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Appointments | Sunrise Dental</title>
  <%@ include file="/WEB-INF/views/partials/head.jsp" %>
</head>

<body class="bg-gray-50 text-slate-700">

  <div class="flex h-screen overflow-hidden">

    <c:set var="active" value="appointments" />
    <%@ include file="/WEB-INF/views/partials/sidebar.jsp" %>

    <div class="flex-1 flex flex-col overflow-hidden">

      <jsp:include page="/WEB-INF/views/partials/header.jsp">
        <jsp:param name="pageTitle" value="Appointments"/>
        <jsp:param name="pageSubtitle" value="Book and manage patient appointments"/>
      </jsp:include>

      <main class="flex-1 overflow-y-auto p-6">

        <div class="flex items-center justify-between mb-6">
          <div>
            <h2 class="text-2xl font-bold text-slate-800">Appointments</h2>
            <p class="text-sm text-slate-400">All booked appointments.</p>
          </div>
          <a href="${pageContext.request.contextPath}/appointments/add"
             class="flex items-center gap-2 px-4 py-2 rounded-lg bg-blue-600 text-white text-sm font-medium hover:bg-blue-700">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15"/></svg>
            New Appointment
          </a>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-6">
          <div class="bg-white rounded-xl border border-gray-200 p-5">
            <p class="text-sm text-slate-400">Total Appointments</p>
            <p class="text-2xl font-bold text-slate-800 mt-1">${totalAppointmentCount}</p>
          </div>
        </div>

        <div class="bg-white rounded-xl border border-gray-200">
          <div class="px-5 py-4 border-b border-gray-200">
            <h3 class="font-semibold text-slate-800">All Appointments</h3>
          </div>

          <div class="overflow-x-auto">
            <table class="w-full text-sm">
              <thead>
                <tr class="text-left text-slate-400 border-b border-gray-100">
                  <th class="px-5 py-3 font-medium">Appt #</th>
                  <th class="px-5 py-3 font-medium">Patient</th>
                  <th class="px-5 py-3 font-medium">Dentist</th>
                  <th class="px-5 py-3 font-medium">Treatment</th>
                  <th class="px-5 py-3 font-medium">Date</th>
                  <th class="px-5 py-3 font-medium">Time</th>
                  <th class="px-5 py-3 font-medium">Status</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-100">

                <c:forEach var="a" items="${appointments}">
                  <%-- whole row is clickable -> appointment detail page --%>
                  <tr class="hover:bg-gray-50 cursor-pointer"
                      onclick="location.href='${pageContext.request.contextPath}/appointments/view?id=${a.id}'">
                    <td class="px-5 py-3 font-medium text-blue-600">APT-${a.id}</td>
                    <td class="px-5 py-3 text-slate-600">${a.patientName}</td>
                    <td class="px-5 py-3 text-slate-500">${a.dentistName}</td>
                    <td class="px-5 py-3 text-slate-500">${a.treatmentType}</td>
                    <td class="px-5 py-3 text-slate-500">${a.appointmentDate}</td>
                    <td class="px-5 py-3 text-slate-500">${a.appointmentTime}</td>
                    <td class="px-5 py-3">
                      <span class="px-2 py-1 rounded-full text-xs ${a.status == 'completed' ? 'bg-green-50 text-green-600' : a.status == 'cancelled' ? 'bg-red-50 text-red-600' : 'bg-blue-50 text-blue-600'}">${a.status}</span>
                    </td>
                  </tr>
                </c:forEach>

                <c:if test="${empty appointments}">
                  <tr><td colspan="7" class="px-5 py-8 text-center text-slate-400">No appointments yet.</td></tr>
                </c:if>

              </tbody>
            </table>
          </div>
        </div>

      </main>
    </div>
  </div>
</body>
</html>
