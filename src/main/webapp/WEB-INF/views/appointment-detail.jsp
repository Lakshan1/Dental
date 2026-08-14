<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Appointment APT-${appointment.id} | Sunrise Dental</title>
  <%@ include file="/WEB-INF/views/partials/head.jsp" %>
</head>

<body class="bg-gray-50 text-slate-700">

  <div class="flex h-screen overflow-hidden">

    <c:set var="active" value="appointments" />
    <%@ include file="/WEB-INF/views/partials/sidebar.jsp" %>

    <div class="flex-1 flex flex-col overflow-hidden">

      <jsp:include page="/WEB-INF/views/partials/header.jsp">
        <jsp:param name="pageTitle" value="Appointments"/>
        <jsp:param name="pageSubtitle" value="Appointment details"/>
      </jsp:include>

      <main class="flex-1 overflow-y-auto p-6">

        <a href="${pageContext.request.contextPath}/appointments"
           class="inline-flex items-center gap-1 text-sm text-slate-500 hover:text-slate-700 mb-4">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19.5 7.5 12l7.5-7.5"/></svg>
          Back to Appointments
        </a>

        <div class="max-w-3xl">

          <%-- header row: appointment number + status + actions --%>
          <div class="flex items-center justify-between mb-6">
            <div>
              <h2 class="text-2xl font-bold text-slate-800">Appointment APT-${appointment.id}</h2>
              <p class="text-sm text-slate-400">${appointment.appointmentDate} at ${appointment.appointmentTime}</p>
            </div>
            <div class="flex items-center gap-3">
              <span class="px-3 py-1 rounded-full text-sm ${appointment.status == 'completed' ? 'bg-green-50 text-green-600' : appointment.status == 'cancelled' ? 'bg-red-50 text-red-600' : 'bg-blue-50 text-blue-600'}">${appointment.status}</span>
              <a href="${pageContext.request.contextPath}/appointments/edit?id=${appointment.id}"
                 class="px-4 py-2 rounded-lg border border-gray-300 text-sm font-medium text-slate-600 hover:bg-gray-50">Edit</a>
              <button type="button" onclick="confirmDelete(${appointment.id})"
                      class="px-4 py-2 rounded-lg bg-rose-600 text-white text-sm font-medium hover:bg-rose-700">Delete</button>
            </div>
          </div>

          <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">

            <%-- Patient card --%>
            <div class="bg-white rounded-xl border border-gray-200 p-5">
              <h3 class="font-semibold text-slate-800 mb-3">Patient</h3>
              <dl class="space-y-2 text-sm">
                <div class="flex justify-between"><dt class="text-slate-400">Name</dt><dd class="text-slate-700 font-medium">${appointment.patientName}</dd></div>
                <div class="flex justify-between"><dt class="text-slate-400">Address</dt><dd class="text-slate-700">${empty appointment.patientAddress ? '-' : appointment.patientAddress}</dd></div>
                <div class="flex justify-between"><dt class="text-slate-400">Contact</dt><dd class="text-slate-700">${empty appointment.patientContact ? '-' : appointment.patientContact}</dd></div>
              </dl>
            </div>

            <%-- Dentist card --%>
            <div class="bg-white rounded-xl border border-gray-200 p-5">
              <h3 class="font-semibold text-slate-800 mb-3">Dentist</h3>
              <dl class="space-y-2 text-sm">
                <div class="flex justify-between"><dt class="text-slate-400">Name</dt><dd class="text-slate-700 font-medium">${appointment.dentistName}</dd></div>
                <div class="flex justify-between"><dt class="text-slate-400">Specialization</dt><dd class="text-slate-700">${empty appointment.dentistSpecialization ? '-' : appointment.dentistSpecialization}</dd></div>
                <div class="flex justify-between"><dt class="text-slate-400">Consultation Fee</dt><dd class="text-slate-700">Rs. ${appointment.consultationFee}</dd></div>
              </dl>
            </div>

            <%-- Visit card (full width) --%>
            <div class="bg-white rounded-xl border border-gray-200 p-5 sm:col-span-2">
              <h3 class="font-semibold text-slate-800 mb-3">Visit</h3>
              <dl class="grid grid-cols-2 gap-y-2 text-sm">
                <dt class="text-slate-400">Treatment</dt><dd class="text-slate-700">${appointment.treatmentType}</dd>
                <dt class="text-slate-400">Date</dt><dd class="text-slate-700">${appointment.appointmentDate}</dd>
                <dt class="text-slate-400">Time</dt><dd class="text-slate-700">${appointment.appointmentTime}</dd>
                <dt class="text-slate-400">Status</dt><dd class="text-slate-700 capitalize">${appointment.status}</dd>
              </dl>
            </div>
          </div>
        </div>

      </main>
    </div>
  </div>

  <script>
    // Confirm, then POST to /appointments/delete.
    function confirmDelete(id) {
      Swal.fire({
        title: 'Delete this appointment?',
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
          form.action = '${pageContext.request.contextPath}/appointments/delete';
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
