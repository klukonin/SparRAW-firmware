/* aw_worker__begin_window @ 0x931110, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi_manager__on_aw
 * Зовёт сам: aw__open_event_mask, aw_worker__collect_awake_peers, sxd_hal__write_qset_field, uc_res_886f00__acquire
 */
	.section .text.aw_worker__begin_window,"ax",@progbits
	.global aw_worker__begin_window
aw_worker__begin_window:
	.global L_931110
L_931110:
	st.a r13,[sp,-0xc]
L_931114:
	st blink,[sp, 0x4]
L_931118:
	st_s r14,[sp,0x8]
L_93111a:
	mov_s r13,r0
L_93111c:
	mov r14,0x0
L_931120:
	bl.d L_928f2c
L_931124:
	mov r0,r14
L_931128:
	mov r0,r14
L_93112c:
	bl.d L_930608
L_931130:
	ld r1,[r13, 0xc]
L_931134:
	bl L_921c2c
L_931138:
	stb_s r14,[r13,0x4]
L_93113a:
	stb_s r14,[r13,0x5]
L_93113c:
	bl.d L_925ea4
L_931140:
	mov r0,r13
L_931144:
	ld blink,[sp, 0x4]
L_931148:
	st_s r14,[r13,0x8]
L_93114a:
	ld_s r14,[sp,0x8]
L_93114c:
	j.d [blink]
L_931150:
	ld.ab r13,[sp,0xc]
