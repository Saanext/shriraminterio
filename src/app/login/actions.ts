
'use server'

import { createClient } from '@/lib/supabase/server'
import { headers } from 'next/headers'
import { redirect } from 'next/navigation'

export async function login(formData: FormData) {
  const email = formData.get('email') as string
  const password = formData.get('password') as string
  const supabase = createClient()

  // First, check if the user is in the 'admins' table
  const { data: admin, error: adminError } = await supabase
    .from('admins')
    .select('id')
    .eq('email', email)
    .single();

  if (adminError || !admin) {
    return {
      error: 'Access denied. You are not authorized to log in here.',
    };
  }
  
  // If they are an admin, attempt to sign in
  const { error } = await supabase.auth.signInWithPassword({
    email,
    password,
  })

  if (error) {
    return {
      error: 'Invalid credentials. Please check your email and password.',
    };
  }

  return redirect('/shriramadmin')
}

export async function logout() {
  const supabase = createClient()
  await supabase.auth.signOut()
  return redirect('/login')
}
