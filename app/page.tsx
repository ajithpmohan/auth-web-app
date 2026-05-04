import { cookies } from "next/headers";
import { redirect } from "next/navigation";

export default async function DashboardPage() {
  const cookieStore = await cookies();
  const cookieValue = cookieStore.get("authUser")?.value;

  const authUser = cookieValue ? JSON.parse(cookieValue) : null;

  if (!authUser?.isAuth) {
    redirect("/login");
  }

  return (
    <div className="min-h-screen bg-gray-100 p-6">
      <div className="max-w-5xl mx-auto">
        {/* Header */}
        <div className="mb-6">
          <h1 className="text-3xl font-bold text-gray-800">Dashboard</h1>
          <p className="text-gray-600">Welcome back! You are logged in.</p>
        </div>

        {/* Card */}
        <div className="bg-white rounded-2xl shadow-md p-6">
          <h2 className="text-xl font-semibold mb-2">Overview</h2>
          <p className="text-gray-600">
            Your dashboard will display updates and features as they become
            available.
          </p>
        </div>
      </div>
    </div>
  );
}
