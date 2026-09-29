/* host_if__read_rf_xpm_handler @ 0x8e363c, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   host_if::read_rf_xpm_handler(): XPM read failed. rf_id=%d, xpm_bit_address=0x%x, num_bytes=%d
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log_emit3, hwf_rf_xpm_block_access_check_inputs, hwf_rf_xpm_read_block_8f4b70, mem_pool__alloc_locked, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global host_if__read_rf_xpm_handler
host_if__read_rf_xpm_handler:
	.global L_8e363c
L_8e363c:
	push_s blink
L_8e363e:
	bl L_8c01d8
L_8e3642:
	sub_s sp,sp,0x4
L_8e3644:
	mov_s r16,r0
L_8e3646:
	bl.d L_8c33d0
L_8e364a:
	mov_s r14,r1
L_8e364c:
	mov_s r13,r0
L_8e364e:
	ld r0,[r16, 0x74]
L_8e3652:
	add_s r15,r13,0x4
L_8e3654:
	sub r4,r0,0x4
L_8e3658:
	ldb_s r0,[r14]
L_8e365a:
	mov_s r3,r15
L_8e365c:
	ld_s r1,[r14,0x4]
L_8e365e:
	mov r17,0x0
L_8e3662:
	ld_s r2,[r14,0x8]
L_8e3664:
	bl.d L_8f46f4
L_8e3668:
	mov r5,r17
L_8e366c:
	mov_s r1,0x1
L_8e366e:
	stb_s r1,[r13]
L_8e3670:
	ld_s r2,[r14,0x8]
L_8e3672:
	brne r0,0x1,L_8e3688
L_8e3676:
	ldb_s r0,[r14]
L_8e3678:
	ld_s r1,[r14,0x4]
L_8e367a:
	bl.d L_8f4b70
L_8e367e:
	mov_s r3,r15
L_8e3680:
	brne r0,0x1,L_8e3688
L_8e3684:
	stb r17,[r13]
	.global L_8e3688
L_8e3688:
	ldb_s r0,[r13]
L_8e368a:
	ld r4,[r14, 0x8]
L_8e368e:
	breq_s r0,0,L_8e36a0
L_8e3690:
	ldb_s r2,[r14]
L_8e3692:
	mov_s r1,0x1006134
L_8e3698:
	mov_s r0,0x0
L_8e369a:
	bl.d L_8dcd00
L_8e369e:
	ld_s r3,[r14,0x4]
	.global L_8e36a0
L_8e36a0:
	ld_s r14,[r14,0x8]
L_8e36a2:
	st r17,[sp]
L_8e36a6:
	add r4,r14,0x4
L_8e36aa:
	extw r4,r4
L_8e36ae:
	mov_s r0,r16
L_8e36b0:
	mov_s r1,r13
L_8e36b2:
	mov_s r2,0x0
L_8e36b4:
	mov_s r3,0x1856
L_8e36ba:
	mov_s r5,r2
L_8e36bc:
	mov_s r6,r2
L_8e36be:
	bl.d L_8e4fc4
L_8e36c2:
	mov_s r7,r2
L_8e36c4:
	ldb_s r0,[r13]
L_8e36c6:
	b.d L_8c023c
L_8e36ca:
	add_s sp,sp,0x4
