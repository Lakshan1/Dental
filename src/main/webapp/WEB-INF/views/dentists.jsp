<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Dentists | Sunrise Dental</title>
  <%@ include file="/WEB-INF/views/partials/head.jsp" %>
</head>

<body class="bg-gray-50 text-slate-700">

  <div class="flex h-screen overflow-hidden">

    <%-- LEFT: sidebar, Dentists highlighted --%>
    <c:set var="active" value="dentists" />
    <%@ include file="/WEB-INF/views/partials/sidebar.jsp" %>

    <div class="flex-1 flex flex-col overflow-hidden">

      <jsp:include page="/WEB-INF/views/partials/header.jsp">
        <jsp:param name="pageTitle" value="Dentists"/>
        <jsp:param name="pageSubtitle" value="Manage dentists and their schedules"/>
      </jsp:include>

      <main class="flex-1 overflow-y-auto p-6">

        <%-- heading + Add button --%>
        <div class="flex items-center justify-between mb-6">
          <div>
            <h2 class="text-2xl font-bold text-slate-800">Dentists</h2>
            <p class="text-sm text-slate-400">All dentists, their fees and weekly hours.</p>
          </div>
          <a href="${pageContext.request.contextPath}/dentists/add"
             class="flex items-center gap-2 px-4 py-2 rounded-lg bg-blue-600 text-white text-sm font-medium hover:bg-blue-700">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4.5v15m7.5-7.5h-15"/></svg>
            Add Dentist
          </a>
        </div>

        <%-- summary --%>
        <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-6">
          <div class="bg-white rounded-xl border border-gray-200 p-5">
            <p class="text-sm text-slate-400">Total Dentists</p>
            <p class="text-2xl font-bold text-slate-800 mt-1">${totalDentistCount}</p>
          </div>
        </div>

        <%-- table --%>
        <div class="bg-white rounded-xl border border-gray-200">
          <div class="px-5 py-4 border-b border-gray-200">
            <h3 class="font-semibold text-slate-800">All Dentists</h3>
          </div>

          <div class="overflow-x-auto">
            <table class="w-full text-sm">
              <thead>
                <tr class="text-left text-slate-400 border-b border-gray-100">
                  <th class="px-5 py-3 font-medium">Name</th>
                  <th class="px-5 py-3 font-medium">Specialization</th>
                  <th class="px-5 py-3 font-medium">Fee</th>
                  <th class="px-5 py-3 font-medium">Slot</th>
                  <th class="px-5 py-3 font-medium">Status</th>
                  <th class="px-5 py-3 font-medium text-right">Actions</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-100">

                <%-- loop over the dentists from the servlet --%>
                <c:forEach var="d" items="${dentists}">
                  <tr class="hover:bg-gray-50">
                    <td class="px-5 py-3">
                      <div class="flex items-center gap-3">
                        <div class="h-9 w-9 rounded-full bg-blue-600 text-white flex items-center justify-center font-semibold">${d.name.substring(0,1)}</div>
                        <div>
                          <p class="font-medium text-slate-700">${d.name}</p>
                          <p class="text-xs text-slate-400">${d.email}</p>
                        </div>
                      </div>
                    </td>
                    <td class="px-5 py-3 text-slate-500">${empty d.specialization ? '-' : d.specialization}</td>
                    <td class="px-5 py-3 text-slate-500">Rs. ${d.consultationFee}</td>
                    <td class="px-5 py-3 text-slate-500">${d.slotMinutes} min</td>
                    <td class="px-5 py-3"><span class="px-2 py-1 rounded-full ${d.status == 'active' ? 'bg-green-50 text-green-600' : d.status == 'restricted' ? 'bg-red-50 text-red-600' : 'bg-yellow-50 text-yellow-600'}">${d.status}</span></td>
                    <td class="px-5 py-3">
                      <div class="flex items-center justify-end gap-2">
                        <a href="${pageContext.request.contextPath}/dentists/edit?id=${d.id}" class="p-1.5 rounded-lg text-slate-400 hover:bg-gray-100 hover:text-blue-600">
                          <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M16.5 3.75 20.25 7.5 8 19.75l-4 1 1-4L16.5 3.75Z"/></svg>
                        </a>
                        <button type="button" data-id="${d.id}" data-name="${d.name}" onclick="confirmDelete(this)"
                                class="p-1.5 rounded-lg text-slate-400 hover:bg-rose-50 hover:text-rose-600">
                          <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6 7.5h12M9.5 7.5V6a1.5 1.5 0 0 1 1.5-1.5h2A1.5 1.5 0 0 1 14.5 6v1.5M7 7.5l.7 11a1.5 1.5 0 0 0 1.5 1.4h5.6a1.5 1.5 0 0 0 1.5-1.4l.7-11"/></svg>
                        </button>
                      </div>
                    </td>
                  </tr>
                </c:forEach>

                <%-- friendly message when there are no dentists --%>
                <c:if test="${empty dentists}">
                  <tr><td colspan="6" class="px-5 py-8 text-center text-slate-400">No dentists yet.</td></tr>
                </c:if>

              </tbody>
            </table>
          </div>
        </div>

      </main>
    </div>
  </div>

  <script>
    // confirm then POST to /dentists/delete
    function confirmDelete(btn) {
      const id = btn.dataset.id, name = btn.dataset.name;
      Swal.fire({
        title: 'Delete ' + name + '?',
        text: 'This cannot be undone.',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#e11d48',
        cancelButtonColor: '#6b7280',
        confirmButtonText: 'Yes, delete'
      }).then((result) => {
        if (result.isConfirmed) {
          const form = document.createElement('form');
          form.method = 'POST';
          form.action = '${pageContext.request.contextPath}/dentists/delete';
          const input = document.createElement('input');
          input.type = 'hidden'; input.name = 'id'; input.value = id;
          form.appendChild(input);
          document.body.appendChild(form);
          form.submit();
        }
      });
    }
  </script>
</body>
</html>
