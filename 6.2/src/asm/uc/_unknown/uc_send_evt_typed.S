/* uc_send_evt_typed @ 0x927928, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: traffic_deferral_cfg_cmd_handler, ucode_cmd_0x01_handler, ucode_cmd_0x03_handler
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, irq_safe__deref_field_04, uc_evt__enqueue, uc_read_tsf_lo
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc_send_evt_typed
uc_send_evt_typed:
	.global L_927928
L_927928:
	push_s blink
L_92792a:
	bl L_920230
L_92792e:
	mov_s r15,r0
L_927930:
	mov_s r0,0x802470
L_927936:
	bl.d L_920d4c
L_92793a:
	mov_s r14,r1
L_92793c:
	bl.d L_9364c8
L_927940:
	mov_s r13,r0
L_927942:
	st_s r0,[r13]
L_927944:
	st_s r14,[r13,0x4]
L_927946:
	extw_s r1,r15
L_927948:
	mov_s r0,r13
L_92794a:
	mov_s r2,0x8
L_92794c:
	bl.d L_927958
L_927950:
	mov_s r3,0x0
L_927952:
	b L_92029c
L_927956:
	nop_s
