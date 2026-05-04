import { cookies } from "next/headers";
import { redirect } from "next/navigation";
import LoginForm from "./LoginForm"; // client component

export default async function LoginPage() {
  const cookieStore = await cookies();
  const cookieValue = cookieStore.get("authUser")?.value;

  const authUser = cookieValue ? JSON.parse(cookieValue) : null;

  if (authUser?.isAuth) {
    redirect("/");
  }

  return <LoginForm />;
}
