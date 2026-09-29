/* hwf_rf__wait_reset_done @ 0x8d4740, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_flows_rf.c
 * Зовут его: marlon_r_if_class__init_board_file_inteface
 * Зовёт сам: fw_sysassert_fatal, hwf_rf_reset_done
 */
	.section .text.hwf_rf__wait_reset_done,"ax",@progbits
	.global hwf_rf__wait_reset_done
hwf_rf__wait_reset_done:
	.global L_8d4740
L_8d4740:
	push_s blink
L_8d4742:
	breq_s r0,0,L_8d475a
L_8d4744:
	mov_s r0,blink
L_8d4746:
	mov_s r2,0x1016c54
L_8d474c:
	mov_s r1,0x131a
L_8d4752:
	bl.d L_8c82c0
L_8d4756:
	mov_s r3,0x31
L_8d4758:
	b_s L_8d475e
	.global L_8d475a
L_8d475a:
	bl L_8d46c0
	.global L_8d475e
L_8d475e:
	pop_s blink
L_8d4760:
	j_s [blink]
L_8d4762:
	nop_s
