/* rf__type_is_marlon @ 0x8da594, 16 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: check_rf_boardfile, rf_comm_test
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global rf__type_is_marlon
rf__type_is_marlon:
	.global L_8da594
L_8da594:
	mov_s r0,0x880a7c
L_8da59a:
	ldw_s r0,[r0,0x12]
L_8da59c:
	cmp_s r0,0x1
L_8da59e:
	mov_s r0,0x1
L_8da5a0:
	j_s.d [blink]
L_8da5a2:
	sub_s.ne r0,r0,r0
