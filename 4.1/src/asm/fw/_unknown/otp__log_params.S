/* otp__log_params @ 0x8ee90c, 92 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   OTP params_0. seq_num    = %x,  pcb_id8      = %x
 *   OTP params_1. silicon_id = %x,  wilocity_num = %x
 *   OTP read failed
 * Зовут его: WBE_DRIVER__pcie_boot_init
 * Зовёт сам: __ld_r13_ret, fw_log__emit0, fw_log__emit2, otp__read_counters, rf_comm_test
 */
	.section .text.otp__log_params,"ax",@progbits
	.global otp__log_params
otp__log_params:
	.global L_8ee90c
L_8ee90c:
	push_s blink
L_8ee90e:
	push_s r13
L_8ee910:
	mov_s r0,0x803e84
L_8ee916:
	bl.d L_8c5cac
L_8ee91a:
	ldb_s r1,[r0]
L_8ee91c:
	breq_s r0,0,L_8ee954
L_8ee91e:
	mov_s r13,0x805c04
L_8ee924:
	bl.d L_8ee968
L_8ee928:
	mov_s r0,r13
L_8ee92a:
	mov_s r2,0x1010038
L_8ee930:
	ldb r4,[r13, 0x4]
L_8ee934:
	mov_s r0,0x0
L_8ee936:
	mov_s r1,0x2
L_8ee938:
	bl.d L_8edff8
L_8ee93c:
	ld_s r3,[r13]
L_8ee93e:
	mov_s r2,0x101006c
L_8ee944:
	ldw r4,[r13, 0x6]
L_8ee948:
	mov_s r0,0x0
L_8ee94a:
	mov_s r1,0x2
L_8ee94c:
	bl.d L_8edff8
L_8ee950:
	ldb_s r3,[r13,0x5]
L_8ee952:
	b_s L_8ee962
	.global L_8ee954
L_8ee954:
	mov_s r2,0x10100a0
L_8ee95a:
	mov_s r0,0x0
L_8ee95c:
	bl.d L_8edfb0
L_8ee960:
	mov_s r1,0x1
	.global L_8ee962
L_8ee962:
	b L_8c033c
L_8ee966:
	nop_s
