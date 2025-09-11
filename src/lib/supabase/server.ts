
import { createServerClient, type CookieOptions } from '@supabase/ssr'
import { cookies } from 'next/headers'
import { NextRequest, NextResponse } from 'next/server';

export function createClient(request?: NextRequest) {
  // Create a server's supabase client with project's credentials
  return createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        get(name: string) {
            if (request) {
                return request.cookies.get(name)?.value;
            }
          return cookies().get(name)?.value
        },
        set(name: string, value: string, options: CookieOptions) {
          try {
            if(request) {
                const response = NextResponse.next({ request });
                response.cookies.set({ name, value, ...options });
                return;
            }
            cookies().set({ name, value, ...options })
          } catch (error) {
            // The `set` method was called from a Server Component.
            // This can be ignored if you have middleware refreshing
            // user sessions.
          }
        },
        remove(name: string, options: CookieOptions) {
          try {
            if (request) {
                const response = NextResponse.next({ request });
                response.cookies.set({ name, value: '', ...options });
                return;
            }
            cookies().set({ name, value: '', ...options })
          } catch (error) {
            // The `delete` method was called from a Server Component.
            // This can be ignored if you have middleware refreshing
            // user sessions.
          }
        },
      },
    }
  )
}
