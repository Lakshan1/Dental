<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>New Appointment | Sunrise Dental</title>
  <%@ include file="/WEB-INF/views/partials/head.jsp" %>
</head>

<body class="bg-gray-50 text-slate-700">

  <div class="flex h-screen overflow-hidden">

    <c:set var="active" value="appointments" />
    <%@ include file="/WEB-INF/views/partials/sidebar.jsp" %>

    <div class="flex-1 flex flex-col overflow-hidden">

      <jsp:include page="/WEB-INF/views/partials/header.jsp">
        <jsp:param name="pageTitle" value="Appointments"/>
        <jsp:param name="pageSubtitle" value="Book a new appointment"/>
      </jsp:include>

      <main class="flex-1 overflow-y-auto p-6">

        <a href="${pageContext.request.contextPath}/appointments"
           class="inline-flex items-center gap-1 text-sm text-slate-500 hover:text-slate-700 mb-4">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19.5 7.5 12l7.5-7.5"/></svg>
          Back to Appointments
        </a>

        <div class="max-w-2xl">
          <h2 class="text-2xl font-bold text-slate-800 mb-1">New Appointment</h2>
          <p class="text-sm text-slate-400 mb-6">Enter the patient's NIC - we'll find their record automatically, or let you add a new patient.</p>

          <c:if test="${not empty error}">
            <div class="mb-4 px-4 py-3 rounded-lg bg-rose-50 border border-rose-100 text-sm text-rose-700">${error}</div>
          </c:if>

          <form action="${pageContext.request.contextPath}/appointments/add" method="post"
                class="bg-white rounded-xl border border-gray-200 p-6 space-y-5">

            <%-- ===== Patient: auto-detected from NIC (phone can be shared by
                 several patients, e.g. family, so it can't identify one). ===== --%>
            <div>
              <label class="block text-sm font-medium text-slate-700 mb-1">Patient NIC</label>
              <input type="text" id="nic" name="nic" value="${param.nic}" required
                     placeholder="e.g. 200012345678 or 981234567V" oninput="onNicInput()"
                     class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none"/>
              <p id="patientStatus" class="text-xs text-slate-400 mt-1"></p>

              <%-- Hidden once a match is found; the servlet uses this to reuse that patient. --%>
              <input type="hidden" id="patientId" name="patientId" value="${param.patientId}"/>

              <%-- Shown when an existing patient is found for the typed NIC. --%>
              <div id="foundPatientCard" class="mt-3 p-3 rounded-lg bg-emerald-50 border border-emerald-100 text-sm text-emerald-700" style="display:none">
                <span id="foundPatientText"></span>
              </div>

              <%-- Shown when no patient matches - fill these in to create one. --%>
              <div id="newPatientFields" class="grid grid-cols-1 sm:grid-cols-2 gap-4 mt-3" style="display:none">
                <div class="sm:col-span-2">
                  <input type="text" id="newPatientName" name="newPatientName" value="${param.newPatientName}" placeholder="Patient name"
                         class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none"/>
                </div>
                <div class="sm:col-span-2">
                  <input type="text" name="newPatientAddress" value="${param.newPatientAddress}" placeholder="Address"
                         class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none"/>
                </div>
                <div class="sm:col-span-2">
                  <input type="text" name="newPatientContact" value="${param.newPatientContact}" placeholder="Contact number"
                         class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none"/>
                </div>
              </div>
            </div>

            <%-- ===== Visit details ===== --%>
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div>
                <label class="block text-sm font-medium text-slate-700 mb-1">Dentist</label>
                <select name="dentistId" onchange="loadSlots()"
                        class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 bg-white focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none">
                  <option value="">-- Select a dentist --</option>
                  <c:forEach var="d" items="${dentists}">
                    <option value="${d.id}" ${param.dentistId == d.id ? 'selected' : ''}>${d.name}<c:if test="${not empty d.specialization}"> - ${d.specialization}</c:if></option>
                  </c:forEach>
                </select>
              </div>
              <div>
                <label class="block text-sm font-medium text-slate-700 mb-1">Treatment Type</label>
                <select name="treatmentType"
                        class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 bg-white focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none">
                  <option value="">-- Select --</option>
                  <c:forEach var="t" items="${['Checkup','Cleaning','Filling','Root Canal','Extraction','Whitening','Braces']}">
                    <option value="${t}" ${param.treatmentType == t ? 'selected' : ''}>${t}</option>
                  </c:forEach>
                </select>
              </div>
              <div>
                <label class="block text-sm font-medium text-slate-700 mb-1">Date</label>
                <%-- min = today, so the date picker itself won't offer past dates. --%>
                <input type="date" name="appointmentDate" value="${param.appointmentDate}" onchange="loadSlots()"
                       min="<%= java.time.LocalDate.now() %>"
                       class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none"/>
              </div>
              <div>
                <label class="block text-sm font-medium text-slate-700 mb-1">Time</label>
                <%-- Filled from /appointments/slots based on the chosen dentist + date. --%>
                <select id="timeSelect" name="appointmentTime"
                        class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 bg-white focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none">
                  <option value="">Select dentist &amp; date first</option>
                </select>
                <p id="timeHint" class="text-xs text-slate-400 mt-1"></p>
              </div>
              <%-- Status isn't asked for here - every new booking starts "scheduled".
                   It becomes editable once the appointment exists. --%>
            </div>

            <div class="flex items-center justify-end gap-3 pt-2">
              <a href="${pageContext.request.contextPath}/appointments"
                 class="px-4 py-2 rounded-lg border border-gray-300 text-sm font-medium text-slate-600 hover:bg-gray-50">Cancel</a>
              <button type="submit" class="px-4 py-2 rounded-lg bg-blue-600 text-white text-sm font-medium hover:bg-blue-700">Book Appointment</button>
            </div>
          </form>
        </div>

      </main>
    </div>
  </div>

  <script>
    // Debounce the NIC lookup so it fires ~400ms after typing stops,
    // not on every single keystroke.
    var nicLookupTimer;
    function onNicInput() {
      clearTimeout(nicLookupTimer);
      nicLookupTimer = setTimeout(lookupPatient, 400);
    }

    // Ask the server whether a patient with this NIC already exists.
    // Found  -> hide the new-patient fields, show their name/address, reuse their id.
    // Not found -> show the new-patient fields (name + address + contact) to create one.
    function lookupPatient() {
      var nic = document.getElementById('nic').value.trim();
      var statusEl = document.getElementById('patientStatus');
      var patientIdInput = document.getElementById('patientId');
      var newFields = document.getElementById('newPatientFields');
      var foundCard = document.getElementById('foundPatientCard');
      var foundText = document.getElementById('foundPatientText');

      if (!nic) {
        statusEl.textContent = '';
        patientIdInput.value = '';
        newFields.style.display = 'none';
        foundCard.style.display = 'none';
        return;
      }

      statusEl.textContent = 'Checking...';

      var url = '${pageContext.request.contextPath}/patients/lookup?nic=' + encodeURIComponent(nic);
      fetch(url).then(function (r) { return r.json(); }).then(function (data) {
        if (data.found) {
          patientIdInput.value = data.id;
          newFields.style.display = 'none';
          foundCard.style.display = 'block';
          foundText.textContent = 'Existing patient found: ' + data.name + (data.address ? ' (' + data.address + ')' : '');
          statusEl.textContent = '';
        } else {
          patientIdInput.value = '';
          foundCard.style.display = 'none';
          newFields.style.display = 'grid';
          statusEl.textContent = 'No existing patient with this NIC - fill in their details below.';
        }
      }).catch(function () {
        statusEl.textContent = '';
      });
    }

    // Ask the server for free slots for the chosen dentist + date, then fill the
    // time dropdown. Already-booked times are excluded server-side.
    function loadSlots() {
      var dentistId = document.querySelector('[name="dentistId"]').value;
      var date = document.querySelector('[name="appointmentDate"]').value;
      var select = document.getElementById('timeSelect');
      var hint = document.getElementById('timeHint');

      if (!dentistId || !date) {
        select.innerHTML = '<option value="">Select dentist & date first</option>';
        hint.textContent = '';
        return;
      }

      var url = '${pageContext.request.contextPath}/appointments/slots?dentistId='
                + encodeURIComponent(dentistId) + '&date=' + encodeURIComponent(date);

      fetch(url).then(function (r) { return r.json(); }).then(function (slots) {
        if (!slots.length) {
          select.innerHTML = '<option value="">No available slots</option>';
          hint.textContent = 'The dentist is off or fully booked that day.';
          return;
        }
        var selected = '${param.appointmentTime}';   // keep the prior choice on an error re-show
        var html = '<option value="">-- Select a time --</option>';
        slots.forEach(function (s) {
          html += '<option value="' + s + '"' + (s === selected ? ' selected' : '') + '>' + s + '</option>';
        });
        select.innerHTML = html;
        hint.textContent = slots.length + ' slot(s) available';
      }).catch(function () {
        select.innerHTML = '<option value="">Could not load slots</option>';
      });
    }

    window.addEventListener('DOMContentLoaded', function () {
      // If a NIC / dentist+date survived an error re-show, re-run
      // the lookups immediately so the UI matches what was submitted.
      if (document.getElementById('nic').value.trim()) lookupPatient();
      loadSlots();
    });
  </script>
</body>
</html>
