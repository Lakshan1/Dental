<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Dashboard | Sunrise Dental</title>

  <%@ include file="/WEB-INF/views/partials/head.jsp" %>
</head>

<body class="bg-gray-50 text-slate-700">

  <%-- =====================================================================
       PAGE LAYOUT
       A full-height flex row: sidebar on the left, everything else on the
       right. "overflow-hidden" keeps the page itself from scrolling; only
       the <main> content area scrolls.
  ====================================================================== --%>
  <div class="flex h-screen overflow-hidden">

    <%-- LEFT: the sidebar component --%>
    <%@ include file="/WEB-INF/views/partials/sidebar.jsp" %>

    <%-- RIGHT: a vertical column = top bar + scrolling content --%>
    <div class="flex-1 flex flex-col overflow-hidden">

      <%-- TOP: the header component --%>
      <jsp:include page="/WEB-INF/views/partials/header.jsp" >
        <jsp:param name="pageTitle" value="Dashboard"/>
        <jsp:param name="pageSubtitle" value="Welcome back to Sunrise Dental"/>
      </jsp:include>

      <%-- MAIN: the actual dashboard content (this part scrolls) --%>
      <main class="flex-1 overflow-y-auto p-6">

        <%-- ---- Page heading ---- --%>
        <div class="mb-6">
          <h2 class="text-2xl font-bold text-slate-800">Good morning, Admin</h2>
          <p class="text-sm text-slate-400">Here's what's happening at the clinic today.</p>
        </div>

        <%-- =================================================================
             STAT CARDS ROW
             Four summary cards. On small screens they stack; on large screens
             they sit in a row of four (grid-cols-4). Numbers are placeholders.
        ================================================================== --%>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">

          <%-- Card 1: Today's appointments --%>
          <div class="bg-white rounded-xl border border-gray-200 p-5">
            <div class="flex items-center justify-between">
              <span class="text-sm text-slate-400">Today's Appointments</span>
              <span class="h-9 w-9 rounded-lg bg-blue-50 text-blue-600 flex items-center justify-center">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6.75 3v2.25M17.25 3v2.25M3 8.25h18M4.5 5.25h15A1.5 1.5 0 0 1 21 6.75v12A1.5 1.5 0 0 1 19.5 20.25h-15A1.5 1.5 0 0 1 3 18.75v-12A1.5 1.5 0 0 1 4.5 5.25Z"/></svg>
              </span>
            </div>
            <p class="text-3xl font-bold text-slate-800 mt-3">12</p>
            <p class="text-xs text-green-600 mt-1">+3 since yesterday</p>
          </div>

          <%-- Card 2: Total patients --%>
          <div class="bg-white rounded-xl border border-gray-200 p-5">
            <div class="flex items-center justify-between">
              <span class="text-sm text-slate-400">Total Patients</span>
              <span class="h-9 w-9 rounded-lg bg-emerald-50 text-emerald-600 flex items-center justify-center">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M18 19.5a6 6 0 0 0-12 0M12 11a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z"/></svg>
              </span>
            </div>
            <p class="text-3xl font-bold text-slate-800 mt-3">348</p>
            <p class="text-xs text-green-600 mt-1">+18 this month</p>
          </div>

          <%-- Card 3: Active dentists --%>
          <div class="bg-white rounded-xl border border-gray-200 p-5">
            <div class="flex items-center justify-between">
              <span class="text-sm text-slate-400">Active Dentists</span>
              <span class="h-9 w-9 rounded-lg bg-violet-50 text-violet-600 flex items-center justify-center">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8ZM4.5 20.25a7.5 7.5 0 0 1 15 0"/></svg>
              </span>
            </div>
            <p class="text-3xl font-bold text-slate-800 mt-3">6</p>
            <p class="text-xs text-slate-400 mt-1">All on duty</p>
          </div>

          <%-- Card 4: Revenue --%>
          <div class="bg-white rounded-xl border border-gray-200 p-5">
            <div class="flex items-center justify-between">
              <span class="text-sm text-slate-400">Revenue (Month)</span>
              <span class="h-9 w-9 rounded-lg bg-amber-50 text-amber-600 flex items-center justify-center">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 6v12m3-9a3 3 0 0 0-3-1.5c-1.7 0-3 .9-3 2.25S10.3 12 12 12s3 .9 3 2.25S13.7 16.5 12 16.5A3 3 0 0 1 9 15"/></svg>
              </span>
            </div>
            <p class="text-3xl font-bold text-slate-800 mt-3">Rs. 84,500</p>
            <p class="text-xs text-green-600 mt-1">+12% vs last month</p>
          </div>
        </div>

        <%-- =================================================================
             TWO-COLUMN AREA
             Left (wide, spans 2): today's appointments table.
             Right (narrow): a quick-actions / info card.
        ================================================================== --%>
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">

          <%-- ---- Appointments table (takes 2 of the 3 columns) ---- --%>
          <div class="lg:col-span-2 bg-white rounded-xl border border-gray-200">

            <%-- Panel header --%>
            <div class="flex items-center justify-between px-5 py-4 border-b border-gray-200">
              <h3 class="font-semibold text-slate-800">Today's Appointments</h3>
              <a href="#" class="text-sm text-blue-600 hover:underline">View all</a>
            </div>

            <%-- The table. Rows are static placeholder data. --%>
            <div class="overflow-x-auto">
              <table class="w-full text-sm">
                <thead>
                  <tr class="text-left text-slate-400 border-b border-gray-100">
                    <th class="px-5 py-3 font-medium">Time</th>
                    <th class="px-5 py-3 font-medium">Patient</th>
                    <th class="px-5 py-3 font-medium">Dentist</th>
                    <th class="px-5 py-3 font-medium">Service</th>
                    <th class="px-5 py-3 font-medium">Status</th>
                  </tr>
                </thead>
                <tbody class="divide-y divide-gray-100">

                  <%-- Row 1 --%>
                  <tr class="hover:bg-gray-50">
                    <td class="px-5 py-3 text-slate-500">09:00 AM</td>
                    <td class="px-5 py-3 font-medium text-slate-700">Nimal Perera</td>
                    <td class="px-5 py-3 text-slate-500">Dr. Silva</td>
                    <td class="px-5 py-3 text-slate-500">Cleaning</td>
                    <td class="px-5 py-3"><span class="px-2 py-1 rounded-full text-xs bg-green-50 text-green-600">Confirmed</span></td>
                  </tr>

                  <%-- Row 2 --%>
                  <tr class="hover:bg-gray-50">
                    <td class="px-5 py-3 text-slate-500">10:30 AM</td>
                    <td class="px-5 py-3 font-medium text-slate-700">Kamala Fernando</td>
                    <td class="px-5 py-3 text-slate-500">Dr. Jayasuriya</td>
                    <td class="px-5 py-3 text-slate-500">Root Canal</td>
                    <td class="px-5 py-3"><span class="px-2 py-1 rounded-full text-xs bg-amber-50 text-amber-600">Pending</span></td>
                  </tr>

                  <%-- Row 3 --%>
                  <tr class="hover:bg-gray-50">
                    <td class="px-5 py-3 text-slate-500">11:15 AM</td>
                    <td class="px-5 py-3 font-medium text-slate-700">Sunil Bandara</td>
                    <td class="px-5 py-3 text-slate-500">Dr. Silva</td>
                    <td class="px-5 py-3 text-slate-500">Extraction</td>
                    <td class="px-5 py-3"><span class="px-2 py-1 rounded-full text-xs bg-green-50 text-green-600">Confirmed</span></td>
                  </tr>

                  <%-- Row 4 --%>
                  <tr class="hover:bg-gray-50">
                    <td class="px-5 py-3 text-slate-500">02:00 PM</td>
                    <td class="px-5 py-3 font-medium text-slate-700">Ayesha Khan</td>
                    <td class="px-5 py-3 text-slate-500">Dr. Mendis</td>
                    <td class="px-5 py-3 text-slate-500">Whitening</td>
                    <td class="px-5 py-3"><span class="px-2 py-1 rounded-full text-xs bg-rose-50 text-rose-600">Cancelled</span></td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

          <%-- ---- Side card: quick actions ---- --%>
          <div class="bg-white rounded-xl border border-gray-200 p-5">
            <h3 class="font-semibold text-slate-800 mb-4">Quick Actions</h3>

            <%-- A stack of buttons (visual only). --%>
            <div class="space-y-3">
              <button class="w-full flex items-center gap-3 px-4 py-3 rounded-lg bg-blue-600 text-white text-sm font-medium hover:bg-blue-700">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15"/></svg>
                New Appointment
              </button>
              <button class="w-full flex items-center gap-3 px-4 py-3 rounded-lg border border-gray-200 text-slate-600 text-sm font-medium hover:bg-gray-50">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M18 19.5a6 6 0 0 0-12 0M12 11a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z"/></svg>
                Add Patient
              </button>
              <button class="w-full flex items-center gap-3 px-4 py-3 rounded-lg border border-gray-200 text-slate-600 text-sm font-medium hover:bg-gray-50">
                <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3 3v18h18M7.5 15l3-3 3 3 4.5-4.5"/></svg>
                View Reports
              </button>
            </div>

            <%-- A small info note at the bottom of the card. --%>
            <div class="mt-6 p-4 rounded-lg bg-amber-50 border border-amber-100">
              <p class="text-sm font-medium text-amber-700">Next appointment</p>
              <p class="text-xs text-amber-600 mt-1">Nimal Perera at 09:00 AM with Dr. Silva</p>
            </div>
          </div>
        </div>

      </main>
    </div>
  </div>
</body>
</html>
