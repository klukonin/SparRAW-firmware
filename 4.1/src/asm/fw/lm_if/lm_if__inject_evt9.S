/* lm_if__inject_evt9 @ 0x8dc008, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   lm_if.cpp
 * Зовут его: conn_mgr__foreach_active_link, l2_mgr__wmi_scan_cmd
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_sysassert_fatal
 */
	.section .text.lm_if__inject_evt9,"ax",@progbits
	.global lm_if__inject_evt9
lm_if__inject_evt9:
	.global L_8dc008
L_8dc008:
	push_s blink
L_8dc00a:
	push_s r13
L_8dc00c:
	mov_s r13,r0
L_8dc00e:
	ld_s r0,[r0]
L_8dc010:
	breq_s r0,0,L_8dc024
	.global L_8dc012
L_8dc012:
	ld_s r0,[r13]
L_8dc014:
	mov_s r1,0x9
L_8dc016:
	mov_s r2,0x0
L_8dc018:
	mov_s r3,r2
L_8dc01a:
	bl.d L_8d6a1c
L_8dc01e:
	mov_s r4,r2
L_8dc020:
	b L_8c033c
	.global L_8dc024
L_8dc024:
	mov_s r0,blink
L_8dc026:
	mov_s r2,0x1010e10
L_8dc02c:
	mov_s r1,0x1262
L_8dc032:
	bl.d L_8c82c0
L_8dc036:
	mov_s r3,0xa3
L_8dc038:
	b_s L_8dc012
L_8dc03a:
	nop_s
