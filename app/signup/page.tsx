import { cookies } from "next/headers";
import { redirect } from "next/navigation";
import SignupForm from "./SignupForm"; // client component

export default async function SignUpPage() {
  const cookieStore = await cookies();
  const cookieValue = cookieStore.get("authUser")?.value;

  const authUser = cookieValue ? JSON.parse(cookieValue) : null;

  if (authUser?.isAuth) {
    redirect("/");
  }

  return <SignupForm />;
}
