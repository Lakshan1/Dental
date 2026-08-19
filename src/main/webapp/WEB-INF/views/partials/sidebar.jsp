<%-- =========================================================================
     SIDEBAR (left navigation menu)
     A reusable piece included by index.jsp. It is just markup - no logic.
     The links point to "#" for now; wire them to real pages later.
========================================================================= --%>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<aside class="w-64 shrink-0 bg-white border-r border-gray-200 flex flex-col">

  <%-- ---- Brand / logo at the top of the sidebar ---- --%>
  <div class="flex items-center gap-3 px-6 py-4 border-b border-gray-200">
    <%-- Small "sunrise" logo mark: a warm gradient circle --%>
    <div class="h-9 w-9 rounded-lg">
      <img src="${pageContext.request.contextPath}/assets/logo-bg.png" class="h-full w-full object-cover rounded-lg" alt="logo">
    </div>
    <div>
      <p class="font-bold text-slate-800 leading-tight">Sunrise Dental</p>
      <p class="text-xs text-slate-400">Admin Panel</p>
    </div>
  </div>

  <%-- ---- Navigation links ----
       Each link highlights itself when the page's ${active} value matches its
       name. The page sets ${active} (e.g. <c:set var="active" value="staff"/>)
       just before including this sidebar. Pure EL - no taglib needed here. --%>
  <nav class="flex-1 px-3 py-4 space-y-1 overflow-y-auto">

    <%-- Dashboard --%>
    <a href="${pageContext.request.contextPath}/" class="flex items-center gap-3 px-3 py-2 rounded-lg ${active == 'dashboard' ? 'bg-blue-50 text-blue-700 font-medium' : 'text-slate-600 hover:bg-gray-100'}">
      <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" d="M3 9.75 12 3l9 6.75V20a1 1 0 0 1-1 1h-5v-6H9v6H4a1 1 0 0 1-1-1V9.75Z"/>
      </svg>
      Dashboard
    </a>

    <%-- Appointments --%>
    <a href="${pageContext.request.contextPath}/appointments" class="flex items-center gap-3 px-3 py-2 rounded-lg ${active == 'appointments' ? 'bg-blue-50 text-blue-700 font-medium' : 'text-slate-600 hover:bg-gray-100'}">
      <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" d="M6.75 3v2.25M17.25 3v2.25M3 8.25h18M4.5 5.25h15A1.5 1.5 0 0 1 21 6.75v12A1.5 1.5 0 0 1 19.5 20.25h-15A1.5 1.5 0 0 1 3 18.75v-12A1.5 1.5 0 0 1 4.5 5.25Z"/>
      </svg>
      Appointments
    </a>

    <%-- Patients --%>
    <a href="${pageContext.request.contextPath}/patients" class="flex items-center gap-3 px-3 py-2 rounded-lg ${active == 'patients' ? 'bg-blue-50 text-blue-700 font-medium' : 'text-slate-600 hover:bg-gray-100'}">
      <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" d="M15 19.5a3 3 0 0 0-6 0M18 19.5a6 6 0 0 0-12 0M12 11a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z"/>
      </svg>
      Patients
    </a>

    <%-- Dentists --%>
    <a href="${pageContext.request.contextPath}/dentists" class="flex items-center gap-3 px-3 py-2 rounded-lg ${active == 'dentists' ? 'bg-blue-50 text-blue-700 font-medium' : 'text-slate-600 hover:bg-gray-100'}">
      <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" d="M12 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8ZM4.5 20.25a7.5 7.5 0 0 1 15 0"/>
      </svg>
      Dentists
    </a>

    <%-- Staffs --%>
    <c:if test="${sessionScope.user.role == 'admin'}">
      <a href="${pageContext.request.contextPath}/staffs" class="flex items-center gap-3 px-3 py-2 rounded-lg ${active == 'staff' ? 'bg-blue-50 text-blue-700 font-medium' : 'text-slate-600 hover:bg-gray-100'}">
        <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" d="M12 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8ZM4.5 20.25a7.5 7.5 0 0 1 15 0"/>
        </svg>
        Staffs
      </a>
    </c:if>

    <%-- Help --%>
    <a href="${pageContext.request.contextPath}/help" class="flex items-center gap-3 px-3 py-2 rounded-lg ${active == 'help' ? 'bg-blue-50 text-blue-700 font-medium' : 'text-slate-600 hover:bg-gray-100'}">
      <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" d="M9.75 9.75a2.25 2.25 0 1 1 3.4 1.94c-.7.42-1.4.98-1.4 1.81v.5M12 17h.01M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"/>
      </svg>
      Help
    </a>
  </nav>

  <%-- ---- Logout pinned to the bottom ----
       Points to the /logout servlet (the one that clears session + cookie). --%>
  <div class="px-3 py-4 border-t border-gray-200">
    <a onclick="logout()" class="flex items-center gap-3 px-3 py-2 rounded-lg text-rose-600 hover:bg-rose-50">
      <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 9V5.25A1.5 1.5 0 0 0 14.25 3.75h-7.5A1.5 1.5 0 0 0 5.25 5.25v13.5a1.5 1.5 0 0 0 1.5 1.5h7.5a1.5 1.5 0 0 0 1.5-1.5V15M18 12H9m9 0-2.25-2.25M18 12l-2.25 2.25"/>
      </svg>
      Logout
    </a>
  </div>

  <script>
    function logout() {
      Swal.fire({
        title: 'Are you sure you want to logout?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, logout'
      }).then((result) => {
        if (result.isConfirmed) {
          window.location.href = '${pageContext.request.contextPath}/logout';
        }
      });
    }
  </script>
</aside>
