<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Edit Appointment APT-${appointment.id} | Sunrise Dental</title>
  <%@ include file="/WEB-INF/views/partials/head.jsp" %>
</head>

<body class="bg-gray-50 text-slate-700">

  <div class="flex h-screen overflow-hidden">

    <c:set var="active" value="appointments" />
    <%@ include file="/WEB-INF/views/partials/sidebar.jsp" %>

    <div class="flex-1 flex flex-col overflow-hidden">

      <jsp:include page="/WEB-INF/views/partials/header.jsp">
        <jsp:param name="pageTitle" value="Appointments"/>
        <jsp:param name="pageSubtitle" value="Edit an appointment"/>
      </jsp:include>

      <main class="flex-1 overflow-y-auto p-6">

        <a href="${pageContext.request.contextPath}/appointments/view?id=${appointment.id}"
           class="inline-flex items-center gap-1 text-sm text-slate-500 hover:text-slate-700 mb-4">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19.5 7.5 12l7.5-7.5"/></svg>
          Back to appointment
        </a>

        <div class="max-w-2xl">
          <h2 class="text-2xl font-bold text-slate-800 mb-1">Edit Appointment APT-${appointment.id}</h2>
          <p class="text-sm text-slate-400 mb-6">Patient: <span class="font-medium text-slate-600">${appointment.patientName}</span></p>

          <c:if test="${not empty error}">
            <div class="mb-4 px-4 py-3 rounded-lg bg-rose-50 border border-rose-100 text-sm text-rose-700">${error}</div>
          </c:if>

          <form action="${pageContext.request.contextPath}/appointments/edit" method="post"
                class="bg-white rounded-xl border border-gray-200 p-6 space-y-5">

            <input type="hidden" name="id" value="${appointment.id}"/>

            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div>
                <label class="block text-sm font-medium text-slate-700 mb-1">Dentist</label>
                <select name="dentistId" onchange="loadSlots()"
                        class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 bg-white focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none">
                  <c:forEach var="d" items="${dentists}">
                    <option value="${d.id}" ${appointment.dentistId == d.id ? 'selected' : ''}>${d.name}<c:if test="${not empty d.specialization}"> - ${d.specialization}</c:if></option>
                  </c:forEach>
                </select>
              </div>
              <div>
                <label class="block text-sm font-medium text-slate-700 mb-1">Treatment Type</label>
                <select name="treatmentType"
                        class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 bg-white focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none">
                  <c:forEach var="t" items="${['Checkup','Cleaning','Filling','Root Canal','Extraction','Whitening','Braces']}">
                    <option value="${t}" ${appointment.treatmentType == t ? 'selected' : ''}>${t}</option>
                  </c:forEach>
                </select>
              </div>
              <div>
                <label class="block text-sm font-medium text-slate-700 mb-1">Date</label>
                <input type="date" name="appointmentDate" value="${appointment.appointmentDate}" onchange="loadSlots()"
                       class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none"/>
              </div>
              <div>
                <label class="block text-sm font-medium text-slate-700 mb-1">Time</label>
                <select id="timeSelect" name="appointmentTime"
                        class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 bg-white focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none">
                  <option value="${appointment.appointmentTime}" selected>${appointment.appointmentTime}</option>
                </select>
                <p id="timeHint" class="text-xs text-slate-400 mt-1"></p>
              </div>
              <div>
                <label class="block text-sm font-medium text-slate-700 mb-1">Status</label>
                <select name="status"
                        class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 bg-white focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none">
                  <option value="scheduled" ${appointment.status == 'scheduled' ? 'selected' : ''}>Scheduled</option>
                  <option value="completed" ${appointment.status == 'completed' ? 'selected' : ''}>Completed</option>
                  <option value="cancelled" ${appointment.status == 'cancelled' ? 'selected' : ''}>Cancelled</option>
                </select>
              </div>
            </div>

            <div class="flex items-center justify-end gap-3 pt-2">
              <a href="${pageContext.request.contextPath}/appointments/view?id=${appointment.id}"
                 class="px-4 py-2 rounded-lg border border-gray-300 text-sm font-medium text-slate-600 hover:bg-gray-50">Cancel</a>
              <button type="submit" class="px-4 py-2 rounded-lg bg-blue-600 text-white text-sm font-medium hover:bg-blue-700">Save Changes</button>
            </div>
          </form>
        </div>

      </main>
    </div>
  </div>

  <script>
    var CURRENT_TIME = '${appointment.appointmentTime}';
    var EXCLUDE_ID = '${appointment.id}';

    // Load free slots for the chosen dentist + date, keeping this appointment's own slot.
    function loadSlots() {
      var dentistId = document.querySelector('[name="dentistId"]').value;
      var date = document.querySelector('[name="appointmentDate"]').value;
      var select = document.getElementById('timeSelect');
      var hint = document.getElementById('timeHint');
      if (!dentistId || !date) return;

      var url = '${pageContext.request.contextPath}/appointments/slots?dentistId='
                + encodeURIComponent(dentistId) + '&date=' + encodeURIComponent(date)
                + '&excludeId=' + encodeURIComponent(EXCLUDE_ID);

      fetch(url).then(function (r) { return r.json(); }).then(function (slots) {
        if (!slots.length) {
          select.innerHTML = '<option value="">No available slots</option>';
          hint.textContent = 'The dentist is off or fully booked that day.';
          return;
        }
        var html = '<option value="">-- Select a time --</option>';
        slots.forEach(function (s) {
          html += '<option value="' + s + '"' + (s === CURRENT_TIME ? ' selected' : '') + '>' + s + '</option>';
        });
        select.innerHTML = html;
        hint.textContent = slots.length + ' slot(s) available';
      }).catch(function () {});
    }

    window.addEventListener('DOMContentLoaded', loadSlots);
  </script>
</body>
</html>
