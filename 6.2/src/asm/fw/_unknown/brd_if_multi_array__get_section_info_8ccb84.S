/* brd_if_multi_array__get_section_info_8ccb84 @ 0x8ccb84, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if_multi_array::get_section_info: Access to non-initialized Board File Interface
 *   brd_if_multi_array::get_section_info: Bad arguments p_section_info_out=0x%X, section_type=%d, sections_count=%d
 *   brd_if_multi_array::get_section_info(): Section type %d not found in the board file
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, brd_if__noop_hook_c, brd_if_multi_array__find_section, brd_section_info__reset, fw_log_emit0, fw_log_emit1, fw_log_emit3
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global brd_if_multi_array__get_section_info_8ccb84
brd_if_multi_array__get_section_info_8ccb84:
	.global L_8ccb84
L_8ccb84:
	push_s blink
L_8ccb86:
	bl L_8c01e0
L_8ccb8a:
	mov_s r15,r0
L_8ccb8c:
	ld_s r0,[r0,0x50]
L_8ccb8e:
	mov_s r13,r1
L_8ccb90:
	mov_s r14,r2
L_8ccb92:
	brne_s r0,0,L_8ccba4
L_8ccb94:
	mov_s r1,0x100ac98
L_8ccb9a:
	bl.d L_8dcba8
L_8ccb9e:
	mov_s r0,0x0
L_8ccba0:
	mov_s r15,0x0
L_8ccba2:
	b_s L_8ccbee
	.global L_8ccba4
L_8ccba4:
	breq_s r14,0,L_8ccbaa
L_8ccba6:
	brlo r13,0xa,L_8ccbc2
	.global L_8ccbaa
L_8ccbaa:
	mov_s r1,0x100acf0
L_8ccbb0:
	mov_s r15,0x0
L_8ccbb2:
	mov_s r0,r15
L_8ccbb4:
	mov_s r2,r14
L_8ccbb6:
	mov_s r3,r13
L_8ccbb8:
	bl.d L_8dcd00
L_8ccbbc:
	mov r4,0xa
L_8ccbc0:
	b_s L_8ccbee
	.global L_8ccbc2
L_8ccbc2:
	bl.d L_8c67a4
L_8ccbc6:
	mov_s r0,r14
L_8ccbc8:
	mov_s r0,r15
L_8ccbca:
	mov_s r1,r13
L_8ccbcc:
	bl.d L_8caab8
L_8ccbd0:
	mov_s r2,r14
L_8ccbd2:
	brne_s r0,0,L_8ccbe6
L_8ccbd4:
	mov_s r1,0x100ad60
L_8ccbda:
	mov_s r15,0x0
L_8ccbdc:
	mov_s r0,r15
L_8ccbde:
	bl.d L_8dcc10
L_8ccbe2:
	mov_s r2,r13
L_8ccbe4:
	b_s L_8ccbee
	.global L_8ccbe6
L_8ccbe6:
	bl.d L_8ebd14
L_8ccbea:
	mov_s r0,r14
L_8ccbec:
	mov_s r15,0x1
	.global L_8ccbee
L_8ccbee:
	b.d L_8c024c
L_8ccbf2:
	mov_s r0,r15
