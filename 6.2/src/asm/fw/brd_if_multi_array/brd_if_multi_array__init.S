/* brd_if_multi_array__init @ 0x8d8fe4, 116 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   brd_if_multi_array::init: Required Board File Size=%d bytes, board file buffer size=%d bytes
 *   brd_if_multi_array::init: Board File Buffer overflow error. Loaded board file size=%d bytes exceeds allocated board file buffer size=%d bytes
 * Зовут его: marlon_r_if_class__init_board_file_interface
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, brd_if__scan_sections, brd_if_multi_array__verify_board_file_format_version, fw_log_emit2, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global brd_if_multi_array__init
brd_if_multi_array__init:
	.global L_8d8fe4
L_8d8fe4:
	push_s blink
L_8d8fe6:
	bl L_8c01d8
L_8d8fea:
	mov_s r13,r0
L_8d8fec:
	mov_s r14,r2
L_8d8fee:
	st_s r1,[r0,0x48]
L_8d8ff0:
	st_s r2,[r0,0x4c]
L_8d8ff2:
	mov_s r15,0x0
L_8d8ff4:
	st_s r15,[r0,0x50]
L_8d8ff6:
	cmp_s r1,0x0
L_8d8ff8:
	cmp.ne r14,0x0
L_8d8ffc:
	mov.eq r0,0x0
L_8d9000:
	beq_s L_8d9054
L_8d9002:
	mov_s r1,0x1
L_8d9004:
	bl.d L_8ebd18
L_8d9008:
	mov_s r16,r1
L_8d900a:
	breq_s r0,0,L_8d9052
L_8d900c:
	ld_s r1,[r13,0x48]
L_8d900e:
	mov_s r0,r13
L_8d9010:
	add_s r1,r1,0x8
L_8d9012:
	bl.d L_8c6afc
L_8d9016:
	mov_s r2,0xa
L_8d9018:
	mov_s r17,r0
L_8d901a:
	mov_s r1,0x100a76c
L_8d9020:
	mov_s r0,0x20
L_8d9022:
	mov_s r2,r17
L_8d9024:
	bl.d L_8dcc80
L_8d9028:
	mov_s r3,r14
L_8d902a:
	ld_s r0,[r13,0x4c]
L_8d902c:
	brlo r0,r17,L_8d9036
L_8d9030:
	st r16,[r13, 0x50]
L_8d9034:
	b_s L_8d9052
	.global L_8d9036
L_8d9036:
	mov_s r1,0x100a7cc
L_8d903c:
	mov_s r0,r15
L_8d903e:
	mov_s r2,r17
L_8d9040:
	bl.d L_8dcc80
L_8d9044:
	mov_s r3,r14
L_8d9046:
	mov_s r0,blink
L_8d9048:
	mov_s r1,0x1367
L_8d904e:
	bl L_8c9b28
	.global L_8d9052
L_8d9052:
	ld_s r0,[r13,0x50]
	.global L_8d9054
L_8d9054:
	b L_8c023c
