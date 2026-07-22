<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login | Sunrise Dental Clinic</title>

    <!-- tailwind cdn -->
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>

   <link rel="icon" href="${pageContext.request.contextPath}/assets/favicon.ico" type="image/x-icon">

</head>
<body>

      <!-- Main panel -->
      <main class="flex flex-col items-center justify-center py-4 px-4 md:px-8 lg:min-h-screen">
         <div class="grid items-center gap-12 max-w-lg lg:grid-cols-2 lg:max-w-6xl">
            <!-- Left content -->
            <div>
               <h2 class="text-4xl font-bold text-slate-900 !leading-tight lg:text-5xl">
                  Sunrise Dental Clinic - Staff Admin Panel
               </h2>
               <p class="text-base mt-6 text-slate-600 leading-relaxed">
                  Sign in to manage appointments, patient records, and daily schedules for Sunrise Dental Clinic. Authorized staff only.
               </p>

            </div>

            <!-- Right form -->
            <div class="max-w-md lg:ml-auto w-full">
               <!-- Title -->
               <h1 class="text-slate-900 text-3xl font-bold mb-10">
                  Staff sign in
               </h1>

               <!-- Form -->
               <form class="space-y-6" method="POST" action="login">
                  <!-- Email field -->
                  <div>
                     <label for="email"
                        class="mb-2 text-slate-900 font-medium text-sm inline-block">Email</label>
                     <input type="email" id="email" name="email" placeholder="admin@sunrisedental.com" required
                        class="px-3 py-2.5 text-sm text-slate-900 rounded-md bg-white w-full outline-1 -outline-offset-1 outline-slate-300 focus:outline-2 focus:-outline-offset-2 focus:outline-blue-600" />
                  </div>

                  <!-- Password field -->
                  <div>
                     <label for="password"
                        class="mb-2 text-slate-900 font-medium text-sm inline-block">Password</label>
                     <input type="password" id="password" name="password" placeholder="••••••••" required
                        class="px-3 py-2.5 text-sm text-slate-900 rounded-md bg-white w-full outline-1 -outline-offset-1 outline-slate-300 focus:outline-2 focus:-outline-offset-2 focus:outline-blue-600" />
                  </div>

                  <!-- Remember me -->
                  <div class="flex items-start flex-wrap gap-2">
                     <label class="flex items-center group has-[input:checked]:text-slate-900">
                        <input id="remember" name="remember" type="checkbox" class="sr-only" />
                        <!-- Custom box -->
                        <span class="flex h-4 w-4 shrink-0 items-center justify-center rounded outline-1 outline-slate-300 bg-white group-has-[input:checked]:bg-blue-600 group-has-[input:checked]:outline-blue-600 group-focus-within:outline-2 group-focus-within:outline-blue-600" aria-hidden="true">
                           <!-- Checkmark -->
                           <svg class="size-3 text-white opacity-0 group-has-[input:checked]:opacity-100" viewBox="0 0 12 10"
                              fill="none" stroke="currentColor" stroke-width="2">
                              <path d="M1 5l3 3 7-7" />
                           </svg>
                        </span>
                        <span class="ml-3 text-sm text-slate-700">
                           Remember me
                        </span>
                     </label>
                  </div>

                  <c:if test="${not empty error}">
                     <div class="flex items-center p-4 mb-4 text-sm text-red-800 border border-red-300 rounded-lg bg-red-50" role="alert">
                        <svg class="flex-shrink-0 inline w-4 h-4 me-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 20 20">
                           <path d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5ZM9.5 4a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3ZM12 15H8a1 1 0 0 1 0-2h1v-3H8a1 1 0 0 1 0-2h2a1 1 0 0 1 1 1v4h1a1 1 0 0 1 0 2Z"/>
                        </svg>
                        <span class="sr-only">Danger</span>
                        <div>
                           ${error}
                        </div>
                     </div>
                  </c:if>

                  <!-- Submit button -->
                  <button type="submit"
                     class="w-full py-2 px-3.5 text-sm rounded-md font-semibold cursor-pointer text-white border border-blue-600 bg-blue-600 hover:bg-blue-700 transition-all focus:outline-none focus-visible:ring-2 focus-visible:ring-blue-500">
                     Sign in</button>
               </form>

            </div>
         </div>
      </main>

</body>
</html>