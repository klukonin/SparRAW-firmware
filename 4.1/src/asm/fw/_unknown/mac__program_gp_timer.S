/* mac__program_gp_timer @ 0x8e4920, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ut_hw_modes_cmd_0x303
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, mac__load_gp_timer_value, mac_read_tsf64
 */
	.section .text.mac__program_gp_timer,"ax",@progbits
	.global mac__program_gp_timer
mac__program_gp_timer:
	.global L_8e4920
L_8e4920:
	push_s blink
L_8e4922:
	bl L_8c02c4
L_8e4926:
	sub_s sp,sp,0x8
L_8e4928:
	lsr_s r13,r0
L_8e492a:
	mov_s r14,0x886d00
L_8e4930:
	/* add_s r13,0x1 */
	.byte 0x01,0xe5
L_8e4932:
	asl_s r13,r13,0x10
L_8e4934:
	or_s r13,r13,r0
L_8e4936:
	breq_s r1,0,L_8e494e
L_8e4938:
	mov_s r1,sp
L_8e493a:
	mov_s r0,0x0
L_8e493c:
	bl.d L_8e4840
L_8e4940:
	mov_s r2,r0
L_8e4942:
	st_s r13,[r14,0x58]
L_8e4944:
	ld_s r0,[sp,0x0]
L_8e4946:
	bl.d L_8e499c
L_8e494a:
	ld_s r1,[sp,0x4]
L_8e494c:
	b_s L_8e4950
	.global L_8e494e
L_8e494e:
	st_s r13,[r14,0x58]
	.global L_8e4950
L_8e4950:
	b.d L_8c0334
L_8e4954:
	add_s sp,sp,0x8
L_8e4956:
	nop_s
