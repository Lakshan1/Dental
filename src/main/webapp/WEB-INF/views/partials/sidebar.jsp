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

    <%-- Help: opens the panel docked to the right (see below) instead of
         navigating away, so you can follow a step and immediately click the
         real button/link it's pointing at, without losing your place. --%>
    <button type="button" id="helpNavBtn" onclick="openHelpPanel()"
            class="w-full flex items-center gap-3 px-3 py-2 rounded-lg text-slate-600 hover:bg-gray-100">
      <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" d="M9.75 9.75a2.25 2.25 0 1 1 3.4 1.94c-.7.42-1.4.98-1.4 1.81v.5M12 17h.01M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"/>
      </svg>
      Help
    </button>
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

<%-- =========================================================================
     HELP PANEL
     A genuine third column docked to the right - NOT an overlay. JS moves it
     into the page's own flex row (sidebar | main content | help), so the
     main content visibly shrinks to make room, exactly like the sidebar does.

     It stays open across page navigations (this is a normal multi-page app -
     every click is a full page reload) by remembering open/closed and scroll
     position in localStorage, restored on each page load. It only ever
     closes when the X is clicked (or Escape is pressed) - never just because
     you followed a link to another page.

     Included on every page via sidebar.jsp, so Help behaves the same everywhere.
========================================================================= --%>
<div id="helpPanel" class="hidden shrink-0 w-96 border-l border-gray-200 bg-white flex-col overflow-hidden">

  <%-- Panel header: title + close button --%>
  <div class="flex items-center justify-between px-5 py-4 border-b border-gray-200 shrink-0">
    <div>
      <h2 class="font-semibold text-slate-800">Help &amp; Instructions</h2>
      <p class="text-xs text-slate-400">Stays open as you navigate - close with the X</p>
    </div>
    <button type="button" onclick="closeHelpPanel()" aria-label="Close help"
            class="p-1.5 rounded-lg text-slate-400 hover:bg-gray-100 hover:text-slate-600">
      <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12"/>
      </svg>
    </button>
  </div>

  <%-- Panel body: scrolls independently of the main content beside it --%>
  <div id="helpPanelBody" class="flex-1 overflow-y-auto p-5">
    <%@ include file="/WEB-INF/views/partials/help-content.jsp" %>
  </div>
</div>

<script>
  // Make the Help nav button look "active" (or not) - shared by open/close/restore.
  function setHelpNavActive(isActive) {
    var btn = document.getElementById('helpNavBtn');
    if (!btn) return;
    if (isActive) { btn.classList.add('bg-blue-50', 'text-blue-700', 'font-medium'); btn.classList.remove('text-slate-600'); }
    else { btn.classList.remove('bg-blue-50', 'text-blue-700', 'font-medium'); btn.classList.add('text-slate-600'); }
  }

  // Show/hide only - no localStorage write. Used both by the real
  // open/close actions below AND by the on-load restore (which must NOT
  // reset the remembered scroll position back to zero).
  function showHelpPanel() {
    var panel = document.getElementById('helpPanel');
    panel.classList.remove('hidden');
    panel.classList.add('flex');
    setHelpNavActive(true);
  }
  function hideHelpPanel() {
    var panel = document.getElementById('helpPanel');
    panel.classList.add('hidden');
    panel.classList.remove('flex');
    setHelpNavActive(false);
  }

  // The actual button/X actions: change the visible state AND remember it.
  function openHelpPanel() {
    showHelpPanel();
    localStorage.setItem('helpPanelOpen', 'true');
  }
  function closeHelpPanel() {
    hideHelpPanel();
    localStorage.setItem('helpPanelOpen', 'false');
  }

  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape') closeHelpPanel();
  });

  window.addEventListener('DOMContentLoaded', function () {
    // Move the panel to be the LAST child of the page's own sidebar+content
    // flex row, so it becomes a real third column (not just floating on top).
    var outerRow = document.querySelector('.flex.h-screen.overflow-hidden');
    var panel = document.getElementById('helpPanel');
    if (outerRow && panel) outerRow.appendChild(panel);

    // Restore open/closed + scroll position from the last page, if any.
    if (localStorage.getItem('helpPanelOpen') === 'true') {
      showHelpPanel();
      var savedScroll = localStorage.getItem('helpPanelScroll');
      if (savedScroll) document.getElementById('helpPanelBody').scrollTop = parseInt(savedScroll, 10);
    }

    // Remember scroll position as the user reads, so the next page picks up
    // right where they left off instead of snapping back to the top.
    document.getElementById('helpPanelBody').addEventListener('scroll', function () {
      localStorage.setItem('helpPanelScroll', this.scrollTop);
    });
  });
</script>
