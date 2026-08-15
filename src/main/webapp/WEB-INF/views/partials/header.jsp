
<header class="flex items-center justify-between bg-white border-b border-gray-200 px-6 py-3">

  <%-- ---- Left: page title ----
       Change this text per page (e.g. "Appointments", "Patients"). --%>
  <div>
    <h1 class="text-lg font-semibold text-slate-800">${param.pageTitle}</h1>
    <p class="text-xs text-slate-400">${param.pageSubtitle}</p>
  </div>

  <%-- ---- Right: search box, notification bell, user chip ---- --%>
  <div class="flex items-center gap-4">

    <%-- User chip: round avatar (first letter) + name + role.
         ${sessionScope.user.name} shows the logged-in user's name from the session. --%>
    <div class="flex items-center gap-3 pl-4 border-l border-gray-200">
      <div class="h-9 w-9 rounded-full bg-blue-600 text-white flex items-center justify-center font-semibold">
        A
      </div>
      <div class="hidden sm:block leading-tight">
        <p class="text-sm font-medium text-slate-800">${sessionScope.user.name}</p>
        <p class="text-xs text-slate-400 capitalize">${sessionScope.user.role}</p>
      </div>
    </div>
  </div>
</header>
