<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Staff | Sunrise Dental</title>
  <%@ include file="/WEB-INF/views/partials/head.jsp" %>
</head>

<body class="bg-gray-50 text-slate-700">

  <%-- Same page shell as the dashboard: sidebar + (header + content) --%>
  <div class="flex h-screen overflow-hidden">

    <%-- LEFT: sidebar. Tell it which nav item is active. --%>
    <c:set var="active" value="staff" />
    <%@ include file="/WEB-INF/views/partials/sidebar.jsp" %>

    <%-- RIGHT: top bar + scrolling content --%>
    <div class="flex-1 flex flex-col overflow-hidden">

      <%-- TOP: header (pass this page's title as props) --%>
      <jsp:include page="/WEB-INF/views/partials/header.jsp">
        <jsp:param name="pageTitle" value="Staff"/>
        <jsp:param name="pageSubtitle" value="Manage your clinic's team"/>
      </jsp:include>

      <%-- MAIN: staff management content --%>
      <main class="flex-1 overflow-y-auto p-6">

        <%-- ---- Page heading + "Add Staff" button ---- --%>
        <div class="flex items-center justify-between mb-6">
          <div>
            <h2 class="text-2xl font-bold text-slate-800">Staff</h2>
            <p class="text-sm text-slate-400">All dentists and clinic staff.</p>
          </div>

          <%-- Opens your "add staff" form later. Visual only for now. --%>
          <button class="flex items-center gap-2 px-4 py-2 rounded-lg bg-blue-600 text-white text-sm font-medium hover:bg-blue-700">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15"/></svg>
            Add Staff
          </button>
        </div>

        <%-- ---- Small summary row ---- --%>
        <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-6">
          <div class="bg-white rounded-xl border border-gray-200 p-5">
            <p class="text-sm text-slate-400">Total Staff</p>
            <p class="text-2xl font-bold text-slate-800 mt-1">${totalStaffCount}</p>
          </div>
          <div class="bg-white rounded-xl border border-gray-200 p-5">
            <p class="text-sm text-slate-400">On Leave Today</p>
            <p class="text-2xl font-bold text-slate-800 mt-1">${totalOnLeaveStaffCount}</p>
          </div>
          <div class="bg-white rounded-xl border border-gray-200 p-5">
            <p class="text-sm text-slate-400">On Duty Today</p>
            <p class="text-2xl font-bold text-slate-800 mt-1">${totalActiveStaffCount}</p>
          </div>
        </div>

        <%-- ---- Staff table card ---- --%>
        <div class="bg-white rounded-xl border border-gray-200">

          <%-- Card header: title + a search box (visual only) --%>
          <div class="flex items-center justify-between px-5 py-4 border-b border-gray-200">
            <h3 class="font-semibold text-slate-800">All Staff</h3>
            <div class="flex items-center gap-2 bg-gray-100 rounded-lg px-3 py-1.5">
              <svg class="w-4 h-4 text-slate-400" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="m21 21-4.35-4.35M17 10.5a6.5 6.5 0 1 1-13 0 6.5 6.5 0 0 1 13 0Z"/></svg>
              <input type="text" placeholder="Search staff..." class="bg-transparent text-sm text-slate-600 outline-none w-44" onkeyup="searchStaff(event)"/>
            </div>
          </div>

          <%-- The table. Rows are static placeholder data - replace with a
               <c:forEach items="${staffList}"> loop when you wire up the DB. --%>
          <div class="overflow-x-auto">
            <table class="w-full text-sm">
              <thead>
                <tr class="text-left text-slate-400 border-b border-gray-100">
                  <th class="px-5 py-3 font-medium">Name</th>
                  <th class="px-5 py-3 font-medium">Role</th>
                  <th class="px-5 py-3 font-medium">Status</th>
                  <th class="px-5 py-3 font-medium text-right">Actions</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-100">

                <!-- loop through staffList -->
                <c:forEach var="staff" items="${staffs}">
                  <tr class="hover:bg-gray-50">
                    <td class="px-5 py-3">
                      <div class="flex items-center gap-3">
                        <div class="h-9 w-9 rounded-full bg-blue-600 text-white flex items-center justify-center font-semibold">${staff.name.substring(0, 1)}</div>
                        <div>
                          <p class="font-medium text-slate-700">${staff.name}</p>
                          <p class="text-xs text-slate-400">${staff.email}</p>
                        </div>
                      </div>
                    </td>
                    <td class="px-5 py-3 text-slate-500 capitalize">${staff.role}</td>
                    <td class="px-5 py-3"><span class="px-2 py-1 rounded-full ${staff.status == 'active' ? 'bg-green-50 text-green-600' : staff.status == 'restricted' ? 'bg-red-50 text-red-600' : 'bg-yellow-50 text-yellow-600'}">${staff.status}</span></td>
                    <td class="px-5 py-3">
                      <div class="flex items-center justify-end gap-2">
                        <%-- Edit --%>
                        <button class="p-1.5 rounded-lg text-slate-400 hover:bg-gray-100 hover:text-blue-600">
                          <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M16.5 3.75 20.25 7.5 8 19.75l-4 1 1-4L16.5 3.75Z"/></svg>
                        </button>
                        <%-- Delete --%>
                        <button class="p-1.5 rounded-lg text-slate-400 hover:bg-rose-50 hover:text-rose-600">
                          <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6 7.5h12M9.5 7.5V6a1.5 1.5 0 0 1 1.5-1.5h2A1.5 1.5 0 0 1 14.5 6v1.5M7 7.5l.7 11a1.5 1.5 0 0 0 1.5 1.4h5.6a1.5 1.5 0 0 0 1.5-1.4l.7-11"/></svg>
                        </button>
                      </div>
                    </td>
                  </tr>
                </c:forEach>

              </tbody>
            </table>
          </div>

          <%-- Simple footer / pagination hint (visual only) --%>
          <div class="flex items-center justify-between px-5 py-3 border-t border-gray-200 text-sm text-slate-400">
            <span>Showing ${staffs.size()} of ${totalStaffCount} staff</span>
            <div class="flex gap-1">
              <a href="?page=${page - 1}" class="px-3 py-1 rounded-lg border border-gray-200 hover:bg-gray-50">Prev</a>
              <a href="?page=${page + 1}" class="px-3 py-1 rounded-lg border border-gray-200 hover:bg-gray-50">Next</a>
            </div>
          </div>
        </div>

      </main>
    </div>
  </div>

  <script>
    function searchStaff(event) {
      if (event.key === "Enter") {
        event.preventDefault();
        performSearch(event);
      }
    }

    function performSearch(event) {
      const query = event.target.value.toLowerCase();
      
      // set search value as url parameter and reload page
      const url = new URL(window.location.href);
      url.searchParams.set('search', query);
      window.location.href = url.toString();
    }

    window.onload = function() {
      const urlParams = new URLSearchParams(window.location.search);
      const searchQuery = urlParams.get('search');

      const setFocusOnSearch = "${setFocusOnSearch}";
      if (searchQuery) {
        document.querySelector('input[placeholder="Search staff..."]').value = searchQuery;

        if (setFocusOnSearch) {
          document.querySelector('input[placeholder="Search staff..."]').focus();
        }
      }
    }
  </script>
</body>
</html>
