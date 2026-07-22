
<header class="flex items-center justify-between bg-white border-b border-gray-200 px-6 py-3">

  <%-- ---- Left: page title ----
       Change this text per page (e.g. "Appointments", "Patients"). --%>
  <div>
    <h1 class="text-lg font-semibold text-slate-800">${param.pageTitle}</h1>
    <p class="text-xs text-slate-400">${param.pageSubtitle}</p>
  </div>

  <%-- ---- Right: search box, notification bell, user chip ---- --%>
  <div class="flex items-center gap-4">

    <%-- Search box (visual only - hidden on small screens) --%>
    <div class="hidden md:flex items-center gap-2 bg-gray-100 rounded-lg px-3 py-1.5">
      <svg class="w-4 h-4 text-slate-400" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" d="m21 21-4.35-4.35M17 10.5a6.5 6.5 0 1 1-13 0 6.5 6.5 0 0 1 13 0Z"/>
      </svg>
      <input type="text" placeholder="Search..." class="bg-transparent text-sm text-slate-600 outline-none w-40"/>
    </div>

    <%-- Notification bell with a little red "unread" dot --%>
    <button class="relative p-2 rounded-lg hover:bg-gray-100">
      <svg class="w-5 h-5 text-slate-500" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" d="M15 17h5l-1.4-1.4A2 2 0 0 1 18 14.2V11a6 6 0 1 0-12 0v3.2a2 2 0 0 1-.6 1.4L4 17h5m6 0a3 3 0 1 1-6 0"/>
      </svg>
      <span class="absolute top-1.5 right-1.5 h-2 w-2 bg-rose-500 rounded-full"></span>
    </button>

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
