<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Help | Sunrise Dental</title>
  <%@ include file="/WEB-INF/views/partials/head.jsp" %>
</head>

<body class="bg-gray-50 text-slate-700">

  <div class="flex h-screen overflow-hidden">

    <c:set var="active" value="help" />
    <%@ include file="/WEB-INF/views/partials/sidebar.jsp" %>

    <div class="flex-1 flex flex-col overflow-hidden">

      <jsp:include page="/WEB-INF/views/partials/header.jsp">
        <jsp:param name="pageTitle" value="Help"/>
        <jsp:param name="pageSubtitle" value="How to use the system"/>
      </jsp:include>

      <main class="flex-1 overflow-y-auto p-6">

        <div class="max-w-3xl">
          <h2 class="text-2xl font-bold text-slate-800 mb-1">Help &amp; Instructions</h2>
          <p class="text-sm text-slate-400 mb-6">Each step shows a small preview of the screen. The blue part is what to click.</p>

          <%-- Every step = a mini "window" wireframe of our app + a caption.
               The blue block in each wireframe highlights the thing to click. --%>

          <div class="space-y-6">

            <%-- ============ STEP 1: Login ============ --%>
            <section class="bg-white rounded-xl border border-gray-200 p-6 flex items-center gap-5">
              <%-- wireframe: login card --%>
              <div class="shrink-0 w-56 rounded-lg border border-gray-200 overflow-hidden">
                <div class="h-4 bg-gray-100 flex items-center gap-1 px-2">
                  <span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span>
                </div>
                <div class="p-4 flex flex-col items-center gap-2 bg-gray-50 h-28 justify-center">
                  <div class="h-2 w-2/3 bg-gray-300 rounded mb-1"></div>
                  <div class="h-3 w-full bg-white border border-gray-200 rounded"></div>
                  <div class="h-3 w-full bg-white border border-gray-200 rounded"></div>
                  <div class="h-3 w-full bg-blue-500 rounded mt-1"></div>
                </div>
              </div>
              <div>
                <p class="text-xs font-semibold text-blue-600 mb-1">STEP 1</p>
                <h3 class="font-semibold text-slate-800">Log in</h3>
                <p class="text-sm text-slate-500 mt-1">Enter your staff email and password, then click the blue <strong>Sign in</strong> button.</p>
              </div>
            </section>

            <%-- reusable app-window wireframe: sidebar + content. --%>
            <%-- ============ STEP 2: Navigate ============ --%>
            <section class="bg-white rounded-xl border border-gray-200 p-6 flex items-center gap-5">
              <div class="shrink-0 w-56 rounded-lg border border-gray-200 overflow-hidden">
                <div class="h-4 bg-gray-100 flex items-center gap-1 px-2"><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span></div>
                <div class="flex h-28">
                  <div class="w-14 bg-gray-50 border-r border-gray-100 p-2 space-y-1.5">
                    <div class="h-2 rounded bg-blue-500"></div>
                    <div class="h-2 rounded bg-gray-200"></div>
                    <div class="h-2 rounded bg-gray-200"></div>
                    <div class="h-2 rounded bg-gray-200"></div>
                  </div>
                  <div class="flex-1 p-2 space-y-1.5"><div class="h-2 w-1/2 bg-gray-200 rounded"></div><div class="h-2 bg-gray-100 rounded"></div><div class="h-2 bg-gray-100 rounded"></div></div>
                </div>
              </div>
              <div>
                <p class="text-xs font-semibold text-blue-600 mb-1">STEP 2</p>
                <h3 class="font-semibold text-slate-800">Use the sidebar</h3>
                <p class="text-sm text-slate-500 mt-1">Click a section in the <strong>left sidebar</strong> (Appointments, Patients, Dentists, Staff). The active one is highlighted.</p>
              </div>
            </section>

            <%-- ============ STEP 3: Add (Staff/Dentist) ============ --%>
            <section class="bg-white rounded-xl border border-gray-200 p-6 flex items-center gap-5">
              <div class="shrink-0 w-56 rounded-lg border border-gray-200 overflow-hidden">
                <div class="h-4 bg-gray-100 flex items-center gap-1 px-2"><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span></div>
                <div class="flex h-28">
                  <div class="w-14 bg-gray-50 border-r border-gray-100 p-2 space-y-1.5"><div class="h-2 rounded bg-gray-200"></div><div class="h-2 rounded bg-gray-200"></div><div class="h-2 rounded bg-gray-200"></div></div>
                  <div class="flex-1 p-2">
                    <div class="flex justify-between items-center mb-2"><div class="h-2 w-1/3 bg-gray-200 rounded"></div><div class="h-3 w-10 bg-blue-500 rounded"></div></div>
                    <div class="space-y-1.5"><div class="h-2 bg-gray-100 rounded"></div><div class="h-2 bg-gray-100 rounded"></div><div class="h-2 bg-gray-100 rounded"></div></div>
                  </div>
                </div>
              </div>
              <div>
                <p class="text-xs font-semibold text-blue-600 mb-1">STEP 3</p>
                <h3 class="font-semibold text-slate-800">Add a record</h3>
                <p class="text-sm text-slate-500 mt-1">On Staff or Dentists, click the blue <strong>Add</strong> button at the top-right to open the create form.</p>
              </div>
            </section>

            <%-- ============ STEP 4: Fill a form ============ --%>
            <section class="bg-white rounded-xl border border-gray-200 p-6 flex items-center gap-5">
              <div class="shrink-0 w-56 rounded-lg border border-gray-200 overflow-hidden">
                <div class="h-4 bg-gray-100 flex items-center gap-1 px-2"><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span></div>
                <div class="p-3 space-y-2 h-28">
                  <div class="h-2 w-1/4 bg-gray-200 rounded"></div>
                  <div class="h-3 w-full bg-white border border-gray-200 rounded"></div>
                  <div class="h-3 w-full bg-white border border-gray-200 rounded"></div>
                  <div class="flex justify-end"><div class="h-3 w-12 bg-blue-500 rounded"></div></div>
                </div>
              </div>
              <div>
                <p class="text-xs font-semibold text-blue-600 mb-1">STEP 4</p>
                <h3 class="font-semibold text-slate-800">Fill in &amp; save</h3>
                <p class="text-sm text-slate-500 mt-1">Complete the fields and click the blue <strong>Save</strong> button. Errors are shown in red at the top.</p>
              </div>
            </section>

            <%-- ============ STEP 5: Dentist hours ============ --%>
            <section class="bg-white rounded-xl border border-gray-200 p-6 flex items-center gap-5">
              <div class="shrink-0 w-56 rounded-lg border border-gray-200 overflow-hidden">
                <div class="h-4 bg-gray-100 flex items-center gap-1 px-2"><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span></div>
                <div class="p-3 space-y-2 h-28">
                  <div class="h-2 w-1/3 bg-gray-200 rounded"></div>
                  <div class="flex items-center gap-1"><div class="h-2 w-8 bg-gray-200 rounded"></div><div class="h-3 w-8 bg-white border border-gray-200 rounded"></div><div class="h-3 w-8 bg-white border border-gray-200 rounded"></div><div class="h-2 w-8 bg-blue-500 rounded"></div></div>
                  <div class="flex items-center gap-1"><div class="h-2 w-8 bg-gray-200 rounded"></div><div class="h-3 w-8 bg-white border border-gray-200 rounded"></div><div class="h-3 w-8 bg-white border border-gray-200 rounded"></div><div class="h-2 w-8 bg-blue-500 rounded"></div></div>
                </div>
              </div>
              <div>
                <p class="text-xs font-semibold text-blue-600 mb-1">STEP 5</p>
                <h3 class="font-semibold text-slate-800">Set dentist working hours</h3>
                <p class="text-sm text-slate-500 mt-1">Enter start &amp; end times per day. Use the blue <strong>Add to all</strong> to copy one day to every day; leave a day blank for a day off.</p>
              </div>
            </section>

            <%-- ============ STEP 6: Book appointment (patient) ============ --%>
            <section class="bg-white rounded-xl border border-gray-200 p-6 flex items-center gap-5">
              <div class="shrink-0 w-56 rounded-lg border border-gray-200 overflow-hidden">
                <div class="h-4 bg-gray-100 flex items-center gap-1 px-2"><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span></div>
                <div class="p-3 space-y-2 h-28">
                  <div class="flex gap-2"><div class="h-2 w-16 bg-blue-500 rounded"></div><div class="h-2 w-16 bg-gray-200 rounded"></div></div>
                  <div class="h-3 w-full bg-white border border-gray-200 rounded"></div>
                  <div class="grid grid-cols-2 gap-1"><div class="h-3 bg-white border border-gray-200 rounded"></div><div class="h-3 bg-white border border-gray-200 rounded"></div></div>
                </div>
              </div>
              <div>
                <p class="text-xs font-semibold text-blue-600 mb-1">STEP 6</p>
                <h3 class="font-semibold text-slate-800">Book: choose the patient</h3>
                <p class="text-sm text-slate-500 mt-1">On <strong>New Appointment</strong>, pick <strong>Existing patient</strong> from the list, or choose <strong>New patient</strong> and type their details.</p>
              </div>
            </section>

            <%-- ============ STEP 7: Pick a time slot ============ --%>
            <section class="bg-white rounded-xl border border-gray-200 p-6 flex items-center gap-5">
              <div class="shrink-0 w-56 rounded-lg border border-gray-200 overflow-hidden">
                <div class="h-4 bg-gray-100 flex items-center gap-1 px-2"><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span></div>
                <div class="p-3 space-y-2 h-28">
                  <div class="grid grid-cols-2 gap-1"><div class="h-3 bg-white border border-gray-200 rounded"></div><div class="h-3 bg-white border border-gray-200 rounded"></div></div>
                  <div class="h-2 w-1/4 bg-gray-200 rounded"></div>
                  <div class="grid grid-cols-3 gap-1"><div class="h-3 bg-blue-500 rounded"></div><div class="h-3 bg-gray-200 rounded"></div><div class="h-3 bg-gray-200 rounded"></div></div>
                </div>
              </div>
              <div>
                <p class="text-xs font-semibold text-blue-600 mb-1">STEP 7</p>
                <h3 class="font-semibold text-slate-800">Book: pick dentist, date &amp; time</h3>
                <p class="text-sm text-slate-500 mt-1">Choose a dentist and date, then the <strong>available time slots</strong> load automatically (booked times are hidden). Pick one and click <strong>Book Appointment</strong>.</p>
              </div>
            </section>

            <%-- ============ STEP 8: Open a row ============ --%>
            <section class="bg-white rounded-xl border border-gray-200 p-6 flex items-center gap-5">
              <div class="shrink-0 w-56 rounded-lg border border-gray-200 overflow-hidden">
                <div class="h-4 bg-gray-100 flex items-center gap-1 px-2"><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span></div>
                <div class="p-2 space-y-1.5 h-28">
                  <div class="h-2 w-1/3 bg-gray-200 rounded mb-1"></div>
                  <div class="h-4 bg-blue-100 border border-blue-300 rounded"></div>
                  <div class="h-4 bg-gray-100 rounded"></div>
                  <div class="h-4 bg-gray-100 rounded"></div>
                </div>
              </div>
              <div>
                <p class="text-xs font-semibold text-blue-600 mb-1">STEP 8</p>
                <h3 class="font-semibold text-slate-800">Open a record</h3>
                <p class="text-sm text-slate-500 mt-1">Click any <strong>row</strong> in a table (appointment or patient) to open its detail page and see full information.</p>
              </div>
            </section>

            <%-- ============ STEP 9: Edit / Delete ============ --%>
            <section class="bg-white rounded-xl border border-gray-200 p-6 flex items-center gap-5">
              <div class="shrink-0 w-56 rounded-lg border border-gray-200 overflow-hidden">
                <div class="h-4 bg-gray-100 flex items-center gap-1 px-2"><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span></div>
                <div class="p-3 h-28">
                  <div class="flex justify-between items-center mb-2"><div class="h-2 w-1/3 bg-gray-200 rounded"></div><div class="flex gap-1"><div class="h-3 w-8 bg-gray-200 rounded"></div><div class="h-3 w-8 bg-rose-500 rounded"></div></div></div>
                  <div class="space-y-1.5"><div class="h-2 bg-gray-100 rounded"></div><div class="h-2 bg-gray-100 rounded"></div><div class="h-2 bg-gray-100 rounded w-2/3"></div></div>
                </div>
              </div>
              <div>
                <p class="text-xs font-semibold text-blue-600 mb-1">STEP 9</p>
                <h3 class="font-semibold text-slate-800">Edit or delete</h3>
                <p class="text-sm text-slate-500 mt-1">On a detail page use <strong>Edit</strong> to change details, or the red <strong>Delete</strong> button (then confirm) to remove the record.</p>
              </div>
            </section>

            <%-- ============ STEP 10: Logout ============ --%>
            <section class="bg-white rounded-xl border border-gray-200 p-6 flex items-center gap-5">
              <div class="shrink-0 w-56 rounded-lg border border-gray-200 overflow-hidden">
                <div class="h-4 bg-gray-100 flex items-center gap-1 px-2"><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span><span class="h-1.5 w-1.5 rounded-full bg-gray-300"></span></div>
                <div class="flex h-28">
                  <div class="w-14 bg-gray-50 border-r border-gray-100 p-2 flex flex-col">
                    <div class="h-2 rounded bg-gray-200 mb-1.5"></div>
                    <div class="h-2 rounded bg-gray-200 mb-1.5"></div>
                    <div class="mt-auto h-2 rounded bg-rose-400"></div>
                  </div>
                  <div class="flex-1 p-2 space-y-1.5"><div class="h-2 bg-gray-100 rounded"></div><div class="h-2 bg-gray-100 rounded"></div></div>
                </div>
              </div>
              <div>
                <p class="text-xs font-semibold text-blue-600 mb-1">STEP 10</p>
                <h3 class="font-semibold text-slate-800">Log out</h3>
                <p class="text-sm text-slate-500 mt-1">Click the red <strong>Logout</strong> at the bottom of the sidebar and confirm to end your session.</p>
              </div>
            </section>

          </div>
        </div>

      </main>
    </div>
  </div>
</body>
</html>
