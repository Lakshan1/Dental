<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>${patient.name} | Sunrise Dental</title>
  <%@ include file="/WEB-INF/views/partials/head.jsp" %>
</head>

<body class="bg-gray-50 text-slate-700">

  <div class="flex h-screen overflow-hidden">

    <c:set var="active" value="patients" />
    <%@ include file="/WEB-INF/views/partials/sidebar.jsp" %>

    <div class="flex-1 flex flex-col overflow-hidden">

      <jsp:include page="/WEB-INF/views/partials/header.jsp">
        <jsp:param name="pageTitle" value="Patients"/>
        <jsp:param name="pageSubtitle" value="Patient details"/>
      </jsp:include>

      <main class="flex-1 overflow-y-auto p-6">

        <a href="${pageContext.request.contextPath}/patients"
           class="inline-flex items-center gap-1 text-sm text-slate-500 hover:text-slate-700 mb-4">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19.5 7.5 12l7.5-7.5"/></svg>
          Back to Patients
        </a>

        <div class="max-w-3xl">

          <%-- shown when a delete was blocked because the patient has appointments --%>
          <c:if test="${param.err == 'appointments'}">
            <div class="mb-4 px-4 py-3 rounded-lg bg-amber-50 border border-amber-100 text-sm text-amber-700">
              This patient has appointments, so they can't be deleted. Remove their appointments first.
            </div>
          </c:if>

          <div class="flex items-center justify-between mb-6">
            <h2 class="text-2xl font-bold text-slate-800">${patient.name}</h2>
            <div class="flex items-center gap-3">
              <a href="${pageContext.request.contextPath}/patients/edit?id=${patient.id}"
                 class="px-4 py-2 rounded-lg border border-gray-300 text-sm font-medium text-slate-600 hover:bg-gray-50">Edit</a>
              <button type="button" onclick="confirmDelete(${patient.id})"
                      class="px-4 py-2 rounded-lg bg-rose-600 text-white text-sm font-medium hover:bg-rose-700">Delete</button>
            </div>
          </div>

          <%-- Patient info --%>
          <div class="bg-white rounded-xl border border-gray-200 p-5 mb-6">
            <h3 class="font-semibold text-slate-800 mb-3">Details</h3>
            <dl class="grid grid-cols-2 gap-y-2 text-sm">
              <dt class="text-slate-400">Name</dt><dd class="text-slate-700 font-medium">${patient.name}</dd>
              <dt class="text-slate-400">NIC</dt><dd class="text-slate-700">${empty patient.nic ? '-' : patient.nic}</dd>
              <dt class="text-slate-400">Contact</dt><dd class="text-slate-700">${empty patient.contactNumber ? '-' : patient.contactNumber}</dd>
              <dt class="text-slate-400">Address</dt><dd class="text-slate-700">${empty patient.address ? '-' : patient.address}</dd>
            </dl>
          </div>

          <%-- Appointment history --%>
          <div class="bg-white rounded-xl border border-gray-200">
            <div class="px-5 py-4 border-b border-gray-200">
              <h3 class="font-semibold text-slate-800">Appointment History</h3>
            </div>
            <div class="overflow-x-auto">
              <table class="w-full text-sm">
                <thead>
                  <tr class="text-left text-slate-400 border-b border-gray-100">
                    <th class="px-5 py-3 font-medium">Appt #</th>
                    <th class="px-5 py-3 font-medium">Dentist</th>
                    <th class="px-5 py-3 font-medium">Treatment</th>
                    <th class="px-5 py-3 font-medium">Date</th>
                    <th class="px-5 py-3 font-medium">Time</th>
                    <th class="px-5 py-3 font-medium">Status</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-100">
                  <c:forEach var="a" items="${appointments}">
                    <tr class="hover:bg-gray-50 cursor-pointer"
                        onclick="location.href='${pageContext.request.contextPath}/appointments/view?id=${a.id}'">
                      <td class="px-5 py-3 font-medium text-blue-600">APT-${a.id}</td>
                      <td class="px-5 py-3 text-slate-500">${a.dentistName}</td>
                      <td class="px-5 py-3 text-slate-500">${a.treatmentType}</td>
                      <td class="px-5 py-3 text-slate-500">${a.appointmentDate}</td>
                      <td class="px-5 py-3 text-slate-500">${a.appointmentTime}</td>
                      <td class="px-5 py-3"><span class="px-2 py-1 rounded-full text-xs ${a.status == 'completed' ? 'bg-green-50 text-green-600' : a.status == 'cancelled' ? 'bg-red-50 text-red-600' : 'bg-blue-50 text-blue-600'}">${a.status}</span></td>
                    </tr>
                  </c:forEach>
                  <c:if test="${empty appointments}">
                    <tr><td colspan="6" class="px-5 py-8 text-center text-slate-400">No appointments for this patient.</td></tr>
                  </c:if>
                </tbody>
              </table>
            </div>
          </div>
        </div>

      </main>
    </div>
  </div>

  <script>
    function confirmDelete(id) {
      Swal.fire({
        title: 'Delete this patient?',
        text: 'This cannot be undone.',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#e11d48',
        cancelButtonColor: '#6b7280',
        confirmButtonText: 'Yes, delete'
      }).then(function (result) {
        if (result.isConfirmed) {
          var form = document.createElement('form');
          form.method = 'POST';
          form.action = '${pageContext.request.contextPath}/patients/delete';
          var input = document.createElement('input');
          input.type = 'hidden'; input.name = 'id'; input.value = id;
          form.appendChild(input);
          document.body.appendChild(form);
          form.submit();
        }
      });
    }
  </script>
</body>
</html>
