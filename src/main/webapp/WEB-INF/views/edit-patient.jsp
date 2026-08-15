<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Edit Patient | Sunrise Dental</title>
  <%@ include file="/WEB-INF/views/partials/head.jsp" %>
</head>

<body class="bg-gray-50 text-slate-700">

  <div class="flex h-screen overflow-hidden">

    <c:set var="active" value="patients" />
    <%@ include file="/WEB-INF/views/partials/sidebar.jsp" %>

    <div class="flex-1 flex flex-col overflow-hidden">

      <jsp:include page="/WEB-INF/views/partials/header.jsp">
        <jsp:param name="pageTitle" value="Patients"/>
        <jsp:param name="pageSubtitle" value="Edit patient"/>
      </jsp:include>

      <main class="flex-1 overflow-y-auto p-6">

        <a href="${pageContext.request.contextPath}/patients/view?id=${patient.id}"
           class="inline-flex items-center gap-1 text-sm text-slate-500 hover:text-slate-700 mb-4">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15 19.5 7.5 12l7.5-7.5"/></svg>
          Back to patient
        </a>

        <div class="max-w-2xl">
          <h2 class="text-2xl font-bold text-slate-800 mb-6">Edit Patient</h2>

          <c:if test="${not empty error}">
            <div class="mb-4 px-4 py-3 rounded-lg bg-rose-50 border border-rose-100 text-sm text-rose-700">${error}</div>
          </c:if>

          <form action="${pageContext.request.contextPath}/patients/edit" method="post"
                class="bg-white rounded-xl border border-gray-200 p-6 space-y-5">

            <input type="hidden" name="id" value="${patient.id}"/>

            <div>
              <label class="block text-sm font-medium text-slate-700 mb-1">Name</label>
              <input type="text" name="name" value="${patient.name}" required
                     class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none"/>
            </div>
            <div>
              <label class="block text-sm font-medium text-slate-700 mb-1">Contact Number</label>
              <input type="text" name="contact" value="${patient.contactNumber}" required
                     class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none"/>
            </div>
            <div>
              <label class="block text-sm font-medium text-slate-700 mb-1">Address</label>
              <input type="text" name="address" value="${patient.address}"
                     class="w-full px-3 py-2.5 text-sm rounded-lg border border-gray-300 focus:border-blue-600 focus:ring-1 focus:ring-blue-600 outline-none"/>
            </div>

            <div class="flex items-center justify-end gap-3 pt-2">
              <a href="${pageContext.request.contextPath}/patients/view?id=${patient.id}"
                 class="px-4 py-2 rounded-lg border border-gray-300 text-sm font-medium text-slate-600 hover:bg-gray-50">Cancel</a>
              <button type="submit" class="px-4 py-2 rounded-lg bg-blue-600 text-white text-sm font-medium hover:bg-blue-700">Save Changes</button>
            </div>
          </form>
        </div>

      </main>
    </div>
  </div>
</body>
</html>
