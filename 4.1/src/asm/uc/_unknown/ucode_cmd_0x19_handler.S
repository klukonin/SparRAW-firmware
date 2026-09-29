/* ucode_cmd_0x19_handler @ 0x934dac, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: umac_if_cmd_handler
 * Зовёт сам: bf_w_s0_w4_uc, bf_w_s4_w4_uc, bf_w_s8_w15_uc
 */
	.section .text.ucode_cmd_0x19_handler,"ax",@progbits
	.global ucode_cmd_0x19_handler
ucode_cmd_0x19_handler:
	.global L_934dac
L_934dac:
	push_s blink
L_934dae:
	mov_s r2,r0
L_934db0:
	mov_s r0,0x0
L_934db2:
	push_s r0
L_934db4:
	ldw_s r1,[r2,0x2]
L_934db6:
	mov_s r0,sp
L_934db8:
	bmsk_s r1,r1,0xe
L_934dba:
	bl L_9379f4
L_934dbe:
	ldb_s r1,[r2]
L_934dc0:
	bmsk_s r1,r1,0x3
L_934dc2:
	bl L_937988
L_934dc6:
	mov_s r1,0x2
L_934dc8:
	bl L_9379d0
L_934dcc:
	ld_s r0,[sp,0x0]
L_934dce:
	mov_s r1,0x80087c
L_934dd4:
	st_s r0,[r1]
L_934dd6:
	ld_s r0,[r2,0x4]
L_934dd8:
	st_s r0,[r1,0x8]
L_934dda:
	mov_s r0,0x1
L_934ddc:
	st_s r0,[r1,0xc]
L_934dde:
	add_s sp,sp,0x4
L_934de0:
	pop_s blink
L_934de2:
	j_s [blink]
