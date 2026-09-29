/* l2mgr__stop_discovery @ 0x8fbde4, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi__stop_discovery_thunk
 * Зовёт сам: __ld_r13_to_r13_ret, mid__reset_bss_defaults, mid_list__by_mid_fw, stop_find_session
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global l2mgr__stop_discovery
l2mgr__stop_discovery:
	.global L_8fbde4
L_8fbde4:
	push_s blink
L_8fbde6:
	bl.d L_8cc3dc
L_8fbdea:
	push_s r13
L_8fbdec:
	mov_s r13,r0
L_8fbdee:
	bl.d L_8f9b48
L_8fbdf2:
	add r0,r0,0x234
L_8fbdf6:
	add3 r0,r13,0x9
L_8fbdfa:
	mov_s r1,0x8004a4
L_8fbe00:
	mov_s r3,0x803b80
L_8fbe06:
	add_s r2,r3,0x4
L_8fbe08:
	ldw_s r3,[r3,0x26]
L_8fbe0a:
	bl.d L_8c4d24
L_8fbe0e:
	mov r4,0x1
L_8fbe12:
	b L_8c025c
L_8fbe16:
	nop_s
