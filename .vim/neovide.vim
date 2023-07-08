" See: https://neovide.dev/configuration.html

set guifont=MesloLGS\ NF:h10.5
set linespace=0
let g:neovide_scale_factor=1.0

" Transparency
let g:neovide_transparency=0.95
" Mac only for now:
" let g:neovide_transparency=0.0
" let g:transparency=0.95
" let g:neovide_background_color = '#121212'.printf('%x', float2nr(255 * g:transparency))

" Blur
let g:neovide_floating_blur_amount_x = 3.0
let g:neovide_floating_blur_amount_y = 3.0

" Animations
let g:neovide_scroll_animation_length = 0.400
let g:neovide_hide_mouse_when_typing = v:true
" not yet available
" let g:neovide_theme = 'auto'

" Cursor
let g:neovide_cursor_animation_length = 0.10
let g:neovide_cursor_trail_size = 0.6
let g:neovide_cursor_antialiasing = v:false
let g:neovide_cursor_animate_in_insert_mode = v:true
" Switching to and from command line animations only, does not affect cursor
" on the command line itself
let g:neovide_cursor_animate_command_line = v:true
" valid options: "", "railgun", "torpedo", "pixiedust", "sonicboom", "ripple",
" "wireframe",
let g:neovide_cursor_vfx_mode = "railgun"
let g:neovide_cursor_vfx_opacity = 180.0
let g:neovide_cursor_vfx_particle_lifetime = 0.7
let g:neovide_cursor_vfx_particle_density = 50.0
let g:neovide_cursor_vfx_particle_speed = 25.0
" Lower = more in line, higher = more rotation in relation to each other
" Railgun only
let g:neovide_cursor_vfx_particle_phase = 1.3
" Lower is more sine wavy, higher is straighter
let g:neovide_cursor_vfx_particle_curl = 2.2

" Performance
let g:neovide_refresh_rate = 60
let g:neovide_refresh_rate_idle = 5
let g:neovide_no_idle = v:false

" Behavior
let g:neovide_confirm_quit = v:true
let g:neovide_remember_window_size = v:true

" Misc
" Display framegraph
let g:neovide_profiler = v:false

" Bindings

" Copy with Ctrl + Shift + C like the terminal provides
nnoremap <C-S-V> "+yy
vnoremap <C-S-V> "+y

" Paste text in terminal mode
" TODO, doesn't work
" tnoremap <C-S-V> <ESC>"+pi
" Paste text in normal mode
nnoremap <C-S-V> "+p
" Paste text in insert mode
inoremap <C-S-V> <c-r>+
" Paste text in command mode
cnoremap <C-S-V> <c-r>+
