<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Patients | Sunrise Dental</title>
  <%@ include file="/WEB-INF/views/partials/head.jsp" %>
</head>

<body class="bg-gray-50 text-slate-700">

  <div class="flex h-screen overflow-hidden">

    <c:set var="active" value="patients" />
    <%@ include file="/WEB-INF/views/partials/sidebar.jsp" %>

    <div class="flex-1 flex flex-col overflow-hidden">

      <jsp:include page="/WEB-INF/views/partials/header.jsp">
        <jsp:param name="pageTitle" value="Patients"/>
        <jsp:param name="pageSubtitle" value="View and manage patient records"/>
      </jsp:include>

      <main class="flex-1 overflow-y-auto p-6">

        <div class="mb-6">
          <h2 class="text-2xl font-bold text-slate-800">Patients</h2>
          <%-- No "add" button: patients are created when booking an appointment. --%>
          <p class="text-sm text-slate-400">Patients are added automatically when an appointment is booked.</p>
        </div>

        <div class="bg-white rounded-xl border border-gray-200">
          <div class="px-5 py-4 border-b border-gray-200">
            <h3 class="font-semibold text-slate-800">All Patients</h3>
          </div>

          <div class="overflow-x-auto">
            <table class="w-full text-sm">
              <thead>
                <tr class="text-left text-slate-400 border-b border-gray-100">
                  <th class="px-5 py-3 font-medium">Name</th>
                  <th class="px-5 py-3 font-medium">NIC</th>
                  <th class="px-5 py-3 font-medium">Contact</th>
                  <th class="px-5 py-3 font-medium">Address</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-100">

                <c:forEach var="p" items="${patients}">
                  <%-- whole row clickable -> patient detail --%>
                  <tr class="hover:bg-gray-50 cursor-pointer"
                      onclick="location.href='${pageContext.request.contextPath}/patients/view?id=${p.id}'">
                    <td class="px-5 py-3">
                      <div class="flex items-center gap-3">
                        <div class="h-9 w-9 rounded-full bg-blue-600 text-white flex items-center justify-center font-semibold">${p.name.substring(0,1)}</div>
                        <span class="font-medium text-slate-700">${p.name}</span>
                      </div>
                    </td>
                    <td class="px-5 py-3 text-slate-500">${empty p.nic ? '-' : p.nic}</td>
                    <td class="px-5 py-3 text-slate-500">${empty p.contactNumber ? '-' : p.contactNumber}</td>
                    <td class="px-5 py-3 text-slate-500">${empty p.address ? '-' : p.address}</td>
                  </tr>
                </c:forEach>

                <c:if test="${empty patients}">
                  <tr><td colspan="4" class="px-5 py-8 text-center text-slate-400">No patients yet. Book an appointment to add one.</td></tr>
                </c:if>

              </tbody>
            </table>
          </div>
        </div>

      </main>
    </div>
  </div>
</body>
</html>
