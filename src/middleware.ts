
import { type NextRequest, NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'
import { updateSession } from './lib/supabase/middleware'

export async function middleware(request: NextRequest) {
  const { supabase, response } = createClient(request);

  const {
    data: { user },
  } = await supabase.auth.getUser();

  const url = new URL(request.url);

  if (url.pathname.startsWith('/shriramadmin')) {
    if (!user) {
      return NextResponse.redirect(new URL('/login', request.url));
    }

    // Check if the user is in the admins table
    const { data: admin, error } = await supabase
      .from('admins')
      .select('id')
      .eq('email', user.email)
      .single();
    
    if (error || !admin) {
      // Not an admin, sign them out and redirect
      await supabase.auth.signOut();
      const redirectUrl = new URL('/login', request.url);
      redirectUrl.searchParams.set('message', 'You are not authorized to access this page.');
      return NextResponse.redirect(redirectUrl);
    }
  }

  if (url.pathname === '/login' && user) {
     // If user is logged in and tries to access login page, redirect to admin
     return NextResponse.redirect(new URL('/shriramadmin', request.url));
  }

  return await updateSession(request);
}

export const config = {
  matcher: [
    /*
     * Match all request paths except for the ones starting with:
     * - _next/static (static files)
     * - _next/image (image optimization files)
     * - favicon.ico (favicon file)
     * Feel free to modify this pattern to include more paths.
     */
    '/((?!_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp)$).*)',
  ],
}
