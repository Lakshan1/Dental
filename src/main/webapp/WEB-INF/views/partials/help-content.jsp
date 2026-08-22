<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%-- =========================================================================
     SHARED HELP CONTENT
     Included by three places:
       - WEB-INF/views/partials/sidebar.jsp  (the right-side Help drawer,
         available on every in-app page)
       - WEB-INF/views/help.jsp              (a direct-URL full page version)
       - help-guide.jsp                      (standalone public page, linked
         from the login screen)
     Keep this file free of anything that depends on being logged in (no
     ${sessionScope.user...}) and keep the layout a SINGLE COLUMN throughout -
     it has to read well both in a full-width page and in a narrow side panel.
========================================================================= --%>

<p class="text-sm text-slate-400 mb-6">Every step below has its own small preview and a short explanation.</p>

<div class="space-y-8">

  <%-- ===================== SECTION 1: GETTING STARTED ===================== --%>
  <section>
    <p class="text-xs font-semibold text-blue-600 tracking-wide uppercase mb-3">Getting Started</p>
    <div class="space-y-2">

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex flex-col justify-center gap-1">
          <div class="h-2 w-full bg-white border border-gray-200 rounded"></div>
          <div class="h-2 w-full bg-blue-500 rounded"></div>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">Sign in</p>
          <p class="text-xs text-slate-500 mt-0.5">Enter your staff email and password on the login page, then click <strong>Sign in</strong>.</p>
        </div>
      </div>

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex items-center justify-center">
          <svg class="w-6 h-6 text-slate-400" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M16.5 10.5V7.5a4.5 4.5 0 1 0-9 0v3M6.75 10.5h10.5A1.5 1.5 0 0 1 18.75 12v6a1.5 1.5 0 0 1-1.5 1.5H6.75a1.5 1.5 0 0 1-1.5-1.5v-6a1.5 1.5 0 0 1 1.5-1.5Z"/></svg>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">Staff-only access</p>
          <p class="text-xs text-slate-500 mt-0.5">Only staff accounts can log in - dentists and patients don't have a password to sign in with.</p>
        </div>
      </div>

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex items-center justify-center gap-1">
          <span class="px-1.5 py-0.5 rounded-full text-[8px] bg-amber-100 text-amber-700">Leave</span>
          <svg class="w-4 h-4 text-slate-400" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 9v3.75m-9.303 3.376c-.866 1.5.217 3.374 1.948 3.374h14.71c1.73 0 2.813-1.874 1.948-3.374L13.949 3.378c-.866-1.5-3.032-1.5-3.898 0L2.697 16.126ZM12 15.75h.007v.008H12v-.008Z"/></svg>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">On Leave / Restricted blocks login</p>
          <p class="text-xs text-slate-500 mt-0.5">A staff account set to <strong>On Leave</strong> or <strong>Restricted</strong> can't sign in, even with the correct password.</p>
        </div>
      </div>

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex items-center justify-center gap-1.5">
          <div class="h-3 w-3 border border-gray-300 rounded-sm bg-blue-500"></div>
          <svg class="w-4 h-4 text-slate-400" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 6v6l4 2M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"/></svg>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">"Remember me" changes how long you stay signed in</p>
          <p class="text-xs text-slate-500 mt-0.5">Ticked: your session lasts <strong>7 days</strong>. Unticked: it ends after <strong>5 minutes</strong> of inactivity.</p>
        </div>
      </div>

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-1.5 flex gap-1">
          <div class="w-5 space-y-1"><div class="h-1.5 rounded bg-blue-500"></div><div class="h-1.5 rounded bg-gray-200"></div><div class="h-1.5 rounded bg-gray-200"></div></div>
          <div class="flex-1 space-y-1 pt-0.5"><div class="h-1.5 w-3/4 bg-gray-200 rounded"></div><div class="h-1.5 bg-gray-100 rounded"></div></div>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">Use the sidebar to get around</p>
          <p class="text-xs text-slate-500 mt-0.5">Click a section on the left - the page you're on is always highlighted in blue.</p>
        </div>
      </div>

    </div>
  </section>

  <%-- ===================== SECTION 2: STAFF ===================== --%>
  <section>
    <p class="text-xs font-semibold text-blue-600 tracking-wide uppercase mb-3">Managing Staff <span class="normal-case text-slate-400 font-normal">(Admins only)</span></p>
    <div class="space-y-2">

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex flex-col justify-center gap-1">
          <div class="h-2 w-full bg-white border border-gray-200 rounded flex items-center px-0.5"><svg class="w-1.5 h-1.5 text-slate-400" fill="none" stroke="currentColor" stroke-width="3" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="m21 21-4.35-4.35M17 10.5a6.5 6.5 0 1 1-13 0 6.5 6.5 0 0 1 13 0Z"/></svg></div>
          <div class="h-2 w-2/3 bg-gray-200 rounded"></div>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">View &amp; search staff</p>
          <p class="text-xs text-slate-500 mt-0.5">Click <strong>Staffs</strong> in the sidebar. Type a name or email and press <strong>Enter</strong> to search.</p>
        </div>
      </div>

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex flex-col justify-center gap-1">
          <div class="h-2 w-full bg-white border border-gray-200 rounded"></div>
          <div class="h-2 w-2/3 bg-blue-500 rounded"></div>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">Add a staff member</p>
          <p class="text-xs text-slate-500 mt-0.5">Click <strong>Add Staff</strong> and enter a name, email and password, then <strong>Save</strong>.</p>
        </div>
      </div>

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex items-center justify-center gap-1">
          <span class="px-1.5 py-0.5 rounded-full text-[8px] bg-blue-100 text-blue-700">Staff</span>
          <span class="px-1.5 py-0.5 rounded-full text-[8px] bg-green-100 text-green-700">Active</span>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">Role &amp; status are set automatically</p>
          <p class="text-xs text-slate-500 mt-0.5">Every new staff member starts as <strong>Staff / Active</strong> - there's nothing to choose when creating one.</p>
        </div>
      </div>

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex items-center justify-center">
          <svg class="w-6 h-6 text-blue-500" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="m16.5 3.75 3.75 3.75L8 19.75l-4 1 1-4L16.5 3.75Z"/></svg>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">Edit details or change status</p>
          <p class="text-xs text-slate-500 mt-0.5">Open a staff row, click <strong>Edit</strong>, then set them to <strong>On Leave</strong> or <strong>Restricted</strong> to block their login temporarily.</p>
        </div>
      </div>

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex items-center justify-center">
          <svg class="w-6 h-6 text-rose-500" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6 7.5h12M9.5 7.5V6a1.5 1.5 0 0 1 1.5-1.5h2A1.5 1.5 0 0 1 14.5 6v1.5M7 7.5l.7 11a1.5 1.5 0 0 0 1.5 1.4h5.6a1.5 1.5 0 0 0 1.5-1.4l.7-11"/></svg>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">Delete a staff member</p>
          <p class="text-xs text-slate-500 mt-0.5">Click the red delete icon on their row and confirm to remove them permanently.</p>
        </div>
      </div>

    </div>
  </section>

  <%-- ===================== SECTION 3: DENTISTS ===================== --%>
  <section>
    <p class="text-xs font-semibold text-blue-600 tracking-wide uppercase mb-3">Managing Dentists</p>
    <div class="space-y-2">

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex flex-col justify-center gap-1">
          <div class="h-2 w-full bg-white border border-gray-200 rounded"></div>
          <div class="h-2 w-2/3 bg-blue-500 rounded"></div>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">Add a dentist</p>
          <p class="text-xs text-slate-500 mt-0.5">Click <strong>Add Dentist</strong>. There's no password field - dentists don't log in.</p>
        </div>
      </div>

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex flex-col justify-center gap-1">
          <div class="h-2 w-full bg-white border border-gray-200 rounded"></div>
          <div class="h-2 w-full bg-white border border-gray-200 rounded"></div>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">Set the consultation fee &amp; slot length</p>
          <p class="text-xs text-slate-500 mt-0.5">The <strong>fee</strong> feeds into billing later; the <strong>slot length</strong> decides how long each appointment takes.</p>
        </div>
      </div>

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex items-center gap-1">
          <div class="h-2 w-6 bg-gray-200 rounded"></div>
          <div class="h-3 w-4 bg-white border border-gray-200 rounded"></div>
          <div class="h-3 w-4 bg-white border border-gray-200 rounded"></div>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">Enter working hours for each day</p>
          <p class="text-xs text-slate-500 mt-0.5">Set a start and end time per day. Leave both empty to mark that day as a day off.</p>
        </div>
      </div>

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex items-center justify-center gap-2">
          <span class="text-[8px] font-medium text-blue-600">Add to all</span>
          <span class="text-[8px] font-medium text-rose-600">x</span>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">Copy hours to every day, or clear a day</p>
          <p class="text-xs text-slate-500 mt-0.5"><strong>Add to all</strong> copies one day's hours everywhere; <strong>x</strong> quickly clears a single day.</p>
        </div>
      </div>

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex items-center justify-center">
          <svg class="w-6 h-6 text-blue-500" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="m16.5 3.75 3.75 3.75L8 19.75l-4 1 1-4L16.5 3.75Z"/></svg>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">Edit anytime</p>
          <p class="text-xs text-slate-500 mt-0.5">Open <strong>Edit</strong> on a dentist to update their hours, fee or status later.</p>
        </div>
      </div>

    </div>
  </section>

  <%-- ===================== SECTION 4: PATIENTS ===================== --%>
  <section>
    <p class="text-xs font-semibold text-blue-600 tracking-wide uppercase mb-3">Patients</p>
    <div class="space-y-2">

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex items-center justify-center">
          <svg class="w-6 h-6 text-slate-400" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M18 19.5a6 6 0 0 0-12 0M12 11a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z"/></svg>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">There's no "Add Patient" button</p>
          <p class="text-xs text-slate-500 mt-0.5">A patient record is created automatically the first time you book an appointment for them.</p>
        </div>
      </div>

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex items-center justify-center">
          <svg class="w-6 h-6 text-slate-400" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M16.5 10.5V7.5a4.5 4.5 0 1 0-9 0v3M6.75 10.5h10.5A1.5 1.5 0 0 1 18.75 12v6a1.5 1.5 0 0 1-1.5 1.5H6.75a1.5 1.5 0 0 1-1.5-1.5v-6a1.5 1.5 0 0 1 1.5-1.5Z"/></svg>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">NIC identifies each patient - not their phone</p>
          <p class="text-xs text-slate-500 mt-0.5">Several patients (e.g. family members) can safely share one phone number.</p>
        </div>
      </div>

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 space-y-1">
          <div class="h-1.5 bg-gray-100 rounded"></div>
          <div class="h-1.5 bg-gray-100 rounded"></div>
          <div class="h-1.5 w-2/3 bg-gray-100 rounded"></div>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">View a patient's history</p>
          <p class="text-xs text-slate-500 mt-0.5">Click <strong>Patients</strong>, then click a row to see their details and every past appointment.</p>
        </div>
      </div>

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex flex-col justify-center gap-1">
          <div class="h-2 w-full bg-gray-100 border border-gray-200 rounded"></div>
          <div class="h-2 w-full bg-white border border-gray-200 rounded"></div>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">Edit details - NIC is locked</p>
          <p class="text-xs text-slate-500 mt-0.5">You can update name, address and contact number, but the NIC can't be changed once set.</p>
        </div>
      </div>

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex items-center justify-center">
          <svg class="w-6 h-6 text-rose-500" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6 7.5h12M9.5 7.5V6a1.5 1.5 0 0 1 1.5-1.5h2A1.5 1.5 0 0 1 14.5 6v1.5M7 7.5l.7 11a1.5 1.5 0 0 0 1.5 1.4h5.6a1.5 1.5 0 0 0 1.5-1.4l.7-11"/></svg>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">Deleting is blocked if they have appointments</p>
          <p class="text-xs text-slate-500 mt-0.5">Remove or reassign their appointments first if you need to delete a patient record.</p>
        </div>
      </div>

    </div>
  </section>

  <%-- ===================== SECTION 5: APPOINTMENTS ===================== --%>
  <section>
    <p class="text-xs font-semibold text-blue-600 tracking-wide uppercase mb-3">Booking &amp; Managing Appointments</p>
    <div class="space-y-2">

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex flex-col justify-center gap-1">
          <div class="h-2 w-full bg-white border border-gray-200 rounded"></div>
          <div class="h-2 w-full rounded bg-emerald-50 border border-emerald-200 flex items-center px-0.5">
            <svg class="w-1.5 h-1.5 text-emerald-500" fill="none" stroke="currentColor" stroke-width="4" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="m4.5 12.75 6 6 9-13.5"/></svg>
          </div>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">Enter the patient's NIC</p>
          <p class="text-xs text-slate-500 mt-0.5">Click <strong>New Appointment</strong>, then type the NIC - a returning patient's name and address fill in automatically.</p>
        </div>
      </div>

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex flex-col justify-center gap-1">
          <div class="h-2 w-full bg-white border border-gray-200 rounded"></div>
          <div class="h-2 w-full bg-white border border-gray-200 rounded"></div>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">New patient? Fields appear automatically</p>
          <p class="text-xs text-slate-500 mt-0.5">If the NIC isn't found, name, address and contact fields appear so you can add them.</p>
        </div>
      </div>

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 grid grid-cols-3 gap-1">
          <div class="h-3 bg-blue-500 rounded"></div><div class="h-3 bg-gray-200 rounded"></div><div class="h-3 bg-gray-100 rounded"></div>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">Pick a dentist, date &amp; time</p>
          <p class="text-xs text-slate-500 mt-0.5">Available times load automatically from that dentist's hours - past times and already-booked times are hidden.</p>
        </div>
      </div>

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex items-center justify-center">
          <svg class="w-6 h-6 text-rose-400" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M18.364 18.364A9 9 0 1 0 5.636 5.636a9 9 0 0 0 12.728 12.728ZM5.636 5.636l12.728 12.728"/></svg>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">Double-booking is prevented automatically</p>
          <p class="text-xs text-slate-500 mt-0.5">The same dentist can't be booked twice for one slot, and one patient can't be in two appointments at once.</p>
        </div>
      </div>

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex items-center justify-center gap-1">
          <div class="h-3 w-6 bg-white border border-gray-200 rounded"></div>
          <svg class="w-3 h-3 text-blue-500" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="m16.5 3.75 3.75 3.75L8 19.75l-4 1 1-4L16.5 3.75Z"/></svg>
          <svg class="w-3 h-3 text-rose-500" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6 7.5h12M9.5 7.5V6a1.5 1.5 0 0 1 1.5-1.5h2A1.5 1.5 0 0 1 14.5 6v1.5M7 7.5l.7 11a1.5 1.5 0 0 0 1.5 1.4h5.6a1.5 1.5 0 0 0 1.5-1.4l.7-11"/></svg>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">View, edit or delete</p>
          <p class="text-xs text-slate-500 mt-0.5">Click any appointment row to open it, then use <strong>Edit</strong> or <strong>Delete</strong>.</p>
        </div>
      </div>

    </div>
  </section>

  <%-- ===================== SECTION 6: BILLING ===================== --%>
  <section>
    <p class="text-xs font-semibold text-blue-600 tracking-wide uppercase mb-3">Completing a Visit &amp; Billing</p>
    <div class="space-y-2">

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex items-center justify-center">
          <span class="px-1.5 py-0.5 rounded-full text-[8px] bg-green-100 text-green-700">Completed</span>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">Mark the appointment Completed</p>
          <p class="text-xs text-slate-500 mt-0.5">Open the appointment, click <strong>Edit</strong>, then set the status to <strong>Completed</strong>.</p>
        </div>
      </div>

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex items-center justify-center">
          <div class="h-3 w-16 bg-emerald-500 rounded text-[7px] text-white flex items-center justify-center">Generate Bill</div>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">A "Generate Bill" button appears</p>
          <p class="text-xs text-slate-500 mt-0.5">It only shows up once the visit is marked completed - back on the appointment's detail page.</p>
        </div>
      </div>

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex flex-col justify-center gap-1">
          <div class="h-2 w-full bg-white border border-gray-200 rounded"></div>
          <div class="h-2 w-full bg-white border border-gray-200 rounded"></div>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">Enter the treatment amount &amp; any extra fees</p>
          <p class="text-xs text-slate-500 mt-0.5">The dentist's consultation fee is added in automatically - you only type the rest.</p>
        </div>
      </div>

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-1.5 flex flex-col justify-center">
          <div class="flex justify-between px-0.5"><div class="h-1.5 w-6 bg-gray-200 rounded"></div><div class="h-1.5 w-3 bg-gray-200 rounded"></div></div>
          <div class="h-px bg-gray-300 my-1 border-t border-dashed"></div>
          <div class="flex justify-between px-0.5"><div class="h-1.5 w-6 bg-gray-400 rounded"></div><div class="h-1.5 w-3 bg-gray-400 rounded"></div></div>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">View &amp; print the receipt</p>
          <p class="text-xs text-slate-500 mt-0.5">Click <strong>Save &amp; View Bill</strong>, then <strong>Print / Save as PDF</strong> to print or keep a copy.</p>
        </div>
      </div>

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex items-center justify-center">
          <svg class="w-6 h-6 text-blue-500" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="m16.5 3.75 3.75 3.75L8 19.75l-4 1 1-4L16.5 3.75Z"/></svg>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">Made a mistake? Edit it later</p>
          <p class="text-xs text-slate-500 mt-0.5">Use <strong>Edit amounts</strong> on the appointment page to correct a bill after it's generated.</p>
        </div>
      </div>

    </div>
  </section>

  <%-- ===================== SECTION 7: YOUR SESSION ===================== --%>
  <section>
    <p class="text-xs font-semibold text-blue-600 tracking-wide uppercase mb-3">Your Session</p>
    <div class="space-y-2">

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex items-center justify-center">
          <svg class="w-6 h-6 text-rose-500" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15.75 9V5.25A1.5 1.5 0 0 0 14.25 3.75h-7.5A1.5 1.5 0 0 0 5.25 5.25v13.5a1.5 1.5 0 0 0 1.5 1.5h7.5a1.5 1.5 0 0 0 1.5-1.5V15M18 12H9m9 0-2.25-2.25M18 12l-2.25 2.25"/></svg>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">Click Logout</p>
          <p class="text-xs text-slate-500 mt-0.5">It's the red link at the bottom of the sidebar.</p>
        </div>
      </div>

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-1.5 flex flex-col justify-center gap-1">
          <div class="h-1.5 w-2/3 bg-gray-200 rounded mx-auto"></div>
          <div class="h-2 w-1/2 bg-blue-500 rounded mx-auto"></div>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">Confirm to finish</p>
          <p class="text-xs text-slate-500 mt-0.5">A dialog asks you to confirm - this ends your session right away.</p>
        </div>
      </div>

      <div class="flex items-start gap-3 p-3 rounded-lg border border-gray-100 bg-white">
        <div class="shrink-0 w-20 h-14 rounded-md border border-gray-200 bg-gray-50 p-2 flex items-center justify-center">
          <svg class="w-6 h-6 text-slate-400" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 6v6l4 2M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"/></svg>
        </div>
        <div>
          <p class="text-sm font-semibold text-slate-800">Forgot to log out?</p>
          <p class="text-xs text-slate-500 mt-0.5">An un-remembered session ends by itself after 5 minutes of inactivity.</p>
        </div>
      </div>

    </div>
  </section>

</div>
