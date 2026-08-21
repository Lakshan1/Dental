<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>${mode} Dentist | Sunrise Dental</title>
  <%@ include file="/WEB-INF/views/partials/head.jsp" %>
</head>

<body class="bg-gray-50 text-slate-700">

  <div class="flex h-screen overflow-hidden">

    <c:set var="active" value="dentists" />
    <%@ include file="/WEB-INF/views/partials/sidebar.jsp" %>

    <div class="flex-1 flex flex-col overflow-hidden">

      <jsp:include page="/WEB-INF/views/partials/header.jsp">
        <jsp:param name="pageTitle" value="Dentists"/>
        <jsp:param name="pageSubtitle" value="Add or edit a dentist"/>
      </jsp:include>

      <main class="flex-1 overflow-y-auto p-6">

        <a href="${pageContext.request.contextPath}/dentists"
           class="inline-flex items-center gap-1 text-sm text-slate-500 hover:text-slate-700 mb-4">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19.5 7.5 12l7.5-7.5"/></svg>
          Back to Dentists
        </a>

        <div class="max-w-3xl">
          <h2 class="text-2xl font-bold text-slate-800 mb-1">${mode} Dentist</h2>
          <p class="text-sm text-slate-400 mb-6">Details, consultation fee and weekly working hours.</p>

          <%-- server-side error --%>
          <c:if test="${not empty error}">
            <div class="mb-4 px-4 py-3 rounded-lg bg-rose-50 border border-rose-100 text-sm text-rose-700">${error}</div>
          </c:if>

          <%-- The form posts to ${formAction}: /dentists/add or /dentists/edit --%>
          <form action="${formAction}" method="post" class="bg-white rounded-xl border border-gray-200 p-6 space-y-6">

            <%-- edit needs the id; add does not --%>
            <c:if test="${mode == 'Edit'}">
              <input type="hidden" name="id" value="${dentist.id}"/>
            </c:if>

            <%-- ===== Personal details ===== --%>
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div>
                <label class="block text-sm font-medium text-slate-700 mb-1">Full Name</label>
                <input type="text" name="name" value="${dentist.name}" required
                       class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none"/>
              </div>
              <div>
                <label class="block text-sm font-medium text-slate-700 mb-1">Email</label>
                <input type="email" name="email" value="${dentist.email}" required
                       class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none"/>
              </div>
              <div>
                <label class="block text-sm font-medium text-slate-700 mb-1">Phone</label>
                <input type="text" name="phone" value="${dentist.phone}"
                       class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none"/>
              </div>
            </div>

            <%-- ===== Professional details ===== --%>
            <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
              <div>
                <label class="block text-sm font-medium text-slate-700 mb-1">Specialization</label>
                <input type="text" name="specialization" value="${dentist.specialization}"
                       placeholder="e.g. Orthodontics"
                       class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none"/>
              </div>
              <div>
                <label class="block text-sm font-medium text-slate-700 mb-1">Consultation Fee (Rs.)</label>
                <input type="number" name="consultationFee" value="${dentist.consultationFee}" min="0" step="0.01" required
                       placeholder="e.g. 1500"
                       class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none"/>
              </div>
              <div>
                <label class="block text-sm font-medium text-slate-700 mb-1">Slot Length (min)</label>
                <input type="number" name="slotMinutes" value="${dentist.slotMinutes}" min="1" required
                       placeholder="30"
                       class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none"/>
              </div>
            </div>

            <%-- Status isn't asked for on Add - every dentist starts "active".
                 It becomes editable once the dentist exists. --%>
            <c:if test="${mode == 'Edit'}">
              <div>
                <label class="block text-sm font-medium text-slate-700 mb-1">Status</label>
                <select name="status"
                        class="w-full sm:w-1/3 px-3 py-2.5 text-sm rounded-lg border border-gray-300 bg-white focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none">
                  <option value="active"     ${dentist.status == 'active' ? 'selected' : ''}>Active</option>
                  <option value="leave"      ${dentist.status == 'leave' ? 'selected' : ''}>On Leave</option>
                  <option value="restricted" ${dentist.status == 'restricted' ? 'selected' : ''}>Restricted</option>
                </select>
              </div>
            </c:if>

            <%-- ===== Weekly working hours =====
                 One start + end per day. Leave both blank to mark a day off. --%>
            <div>
              <label class="block text-sm font-medium text-slate-700 mb-2">Weekly Working Hours</label>
              <p class="text-xs text-slate-400 mb-3">Leave both times empty for a day off.</p>

              <%-- Each row shows two text buttons only when it has a time value:
                   "Add to all" copies this day to every day, "x" clears this day.
                   See toggleRow() / copyToAll() / clearRow() in the script below. --%>
              <div class="space-y-2">
                <%-- Monday --%>
                <div class="flex items-center gap-3">
                  <span class="w-24 text-sm text-slate-600">Monday</span>
                  <input type="time" name="mon_start" value="${dentist.startTimes.mon}" oninput="toggleRow('mon')" class="px-2 py-1.5 text-sm rounded-lg border border-gray-300 outline-none focus:border-blue-600"/>
                  <span class="text-slate-400">to</span>
                  <input type="time" name="mon_end" value="${dentist.endTimes.mon}" oninput="toggleRow('mon')" class="px-2 py-1.5 text-sm rounded-lg border border-gray-300 outline-none focus:border-blue-600"/>
                  <span id="mon_actions" class="items-center gap-2" style="display:none">
                    <button type="button" onclick="copyToAll('mon')" class="text-xs font-medium text-blue-600 hover:underline">Add to all</button>
                    <button type="button" onclick="clearRow('mon')" title="Clear this day" class="text-xs font-medium text-rose-600 hover:underline">x</button>
                  </span>
                </div>
                <%-- Tuesday --%>
                <div class="flex items-center gap-3">
                  <span class="w-24 text-sm text-slate-600">Tuesday</span>
                  <input type="time" name="tue_start" value="${dentist.startTimes.tue}" oninput="toggleRow('tue')" class="px-2 py-1.5 text-sm rounded-lg border border-gray-300 outline-none focus:border-blue-600"/>
                  <span class="text-slate-400">to</span>
                  <input type="time" name="tue_end" value="${dentist.endTimes.tue}" oninput="toggleRow('tue')" class="px-2 py-1.5 text-sm rounded-lg border border-gray-300 outline-none focus:border-blue-600"/>
                  <span id="tue_actions" class="items-center gap-2" style="display:none">
                    <button type="button" onclick="copyToAll('tue')" class="text-xs font-medium text-blue-600 hover:underline">Add to all</button>
                    <button type="button" onclick="clearRow('tue')" title="Clear this day" class="text-xs font-medium text-rose-600 hover:underline">x</button>
                  </span>
                </div>
                <%-- Wednesday --%>
                <div class="flex items-center gap-3">
                  <span class="w-24 text-sm text-slate-600">Wednesday</span>
                  <input type="time" name="wed_start" value="${dentist.startTimes.wed}" oninput="toggleRow('wed')" class="px-2 py-1.5 text-sm rounded-lg border border-gray-300 outline-none focus:border-blue-600"/>
                  <span class="text-slate-400">to</span>
                  <input type="time" name="wed_end" value="${dentist.endTimes.wed}" oninput="toggleRow('wed')" class="px-2 py-1.5 text-sm rounded-lg border border-gray-300 outline-none focus:border-blue-600"/>
                  <span id="wed_actions" class="items-center gap-2" style="display:none">
                    <button type="button" onclick="copyToAll('wed')" class="text-xs font-medium text-blue-600 hover:underline">Add to all</button>
                    <button type="button" onclick="clearRow('wed')" title="Clear this day" class="text-xs font-medium text-rose-600 hover:underline">x</button>
                  </span>
                </div>
                <%-- Thursday --%>
                <div class="flex items-center gap-3">
                  <span class="w-24 text-sm text-slate-600">Thursday</span>
                  <input type="time" name="thu_start" value="${dentist.startTimes.thu}" oninput="toggleRow('thu')" class="px-2 py-1.5 text-sm rounded-lg border border-gray-300 outline-none focus:border-blue-600"/>
                  <span class="text-slate-400">to</span>
                  <input type="time" name="thu_end" value="${dentist.endTimes.thu}" oninput="toggleRow('thu')" class="px-2 py-1.5 text-sm rounded-lg border border-gray-300 outline-none focus:border-blue-600"/>
                  <span id="thu_actions" class="items-center gap-2" style="display:none">
                    <button type="button" onclick="copyToAll('thu')" class="text-xs font-medium text-blue-600 hover:underline">Add to all</button>
                    <button type="button" onclick="clearRow('thu')" title="Clear this day" class="text-xs font-medium text-rose-600 hover:underline">x</button>
                  </span>
                </div>
                <%-- Friday --%>
                <div class="flex items-center gap-3">
                  <span class="w-24 text-sm text-slate-600">Friday</span>
                  <input type="time" name="fri_start" value="${dentist.startTimes.fri}" oninput="toggleRow('fri')" class="px-2 py-1.5 text-sm rounded-lg border border-gray-300 outline-none focus:border-blue-600"/>
                  <span class="text-slate-400">to</span>
                  <input type="time" name="fri_end" value="${dentist.endTimes.fri}" oninput="toggleRow('fri')" class="px-2 py-1.5 text-sm rounded-lg border border-gray-300 outline-none focus:border-blue-600"/>
                  <span id="fri_actions" class="items-center gap-2" style="display:none">
                    <button type="button" onclick="copyToAll('fri')" class="text-xs font-medium text-blue-600 hover:underline">Add to all</button>
                    <button type="button" onclick="clearRow('fri')" title="Clear this day" class="text-xs font-medium text-rose-600 hover:underline">x</button>
                  </span>
                </div>
                <%-- Saturday --%>
                <div class="flex items-center gap-3">
                  <span class="w-24 text-sm text-slate-600">Saturday</span>
                  <input type="time" name="sat_start" value="${dentist.startTimes.sat}" oninput="toggleRow('sat')" class="px-2 py-1.5 text-sm rounded-lg border border-gray-300 outline-none focus:border-blue-600"/>
                  <span class="text-slate-400">to</span>
                  <input type="time" name="sat_end" value="${dentist.endTimes.sat}" oninput="toggleRow('sat')" class="px-2 py-1.5 text-sm rounded-lg border border-gray-300 outline-none focus:border-blue-600"/>
                  <span id="sat_actions" class="items-center gap-2" style="display:none">
                    <button type="button" onclick="copyToAll('sat')" class="text-xs font-medium text-blue-600 hover:underline">Add to all</button>
                    <button type="button" onclick="clearRow('sat')" title="Clear this day" class="text-xs font-medium text-rose-600 hover:underline">x</button>
                  </span>
                </div>
                <%-- Sunday --%>
                <div class="flex items-center gap-3">
                  <span class="w-24 text-sm text-slate-600">Sunday</span>
                  <input type="time" name="sun_start" value="${dentist.startTimes.sun}" oninput="toggleRow('sun')" class="px-2 py-1.5 text-sm rounded-lg border border-gray-300 outline-none focus:border-blue-600"/>
                  <span class="text-slate-400">to</span>
                  <input type="time" name="sun_end" value="${dentist.endTimes.sun}" oninput="toggleRow('sun')" class="px-2 py-1.5 text-sm rounded-lg border border-gray-300 outline-none focus:border-blue-600"/>
                  <span id="sun_actions" class="items-center gap-2" style="display:none">
                    <button type="button" onclick="copyToAll('sun')" class="text-xs font-medium text-blue-600 hover:underline">Add to all</button>
                    <button type="button" onclick="clearRow('sun')" title="Clear this day" class="text-xs font-medium text-rose-600 hover:underline">x</button>
                  </span>
                </div>
              </div>
            </div>

            <%-- buttons --%>
            <div class="flex items-center justify-end gap-3 pt-2">
              <a href="${pageContext.request.contextPath}/dentists"
                 class="px-4 py-2 rounded-lg border border-gray-300 text-sm font-medium text-slate-600 hover:bg-gray-50">Cancel</a>
              <button type="submit" class="px-4 py-2 rounded-lg bg-blue-600 text-white text-sm font-medium hover:bg-blue-700">Save Dentist</button>
            </div>
          </form>
        </div>

      </main>
    </div>
  </div>

  <script>
    var DAYS = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];

    // Show a row's buttons only when it has a start OR end time.
    function toggleRow(day) {
      var start = document.querySelector('[name="' + day + '_start"]').value;
      var end = document.querySelector('[name="' + day + '_end"]').value;
      var hasValue = start !== '' || end !== '';
      document.getElementById(day + '_actions').style.display = hasValue ? 'inline-flex' : 'none';
    }

    // Copy one day's start + end into every day, then refresh all buttons.
    function copyToAll(day) {
      var start = document.querySelector('[name="' + day + '_start"]').value;
      var end = document.querySelector('[name="' + day + '_end"]').value;
      DAYS.forEach(function (d) {
        document.querySelector('[name="' + d + '_start"]').value = start;
        document.querySelector('[name="' + d + '_end"]').value = end;
        toggleRow(d);
      });
    }

    // Clear one day's times (dentist not available that day) + hide its buttons.
    function clearRow(day) {
      document.querySelector('[name="' + day + '_start"]').value = '';
      document.querySelector('[name="' + day + '_end"]').value = '';
      toggleRow(day);
    }

    // On load, show buttons for any days already filled (edit mode).
    window.addEventListener('DOMContentLoaded', function () {
      DAYS.forEach(toggleRow);
    });
  </script>
</body>
</html>
