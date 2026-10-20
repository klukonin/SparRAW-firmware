/* abif__ack_unmask_fs_unlock_irq @ 0x8d0100, 20 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwd_abif__fs_on
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global abif__ack_unmask_fs_unlock_irq
abif__ack_unmask_fs_unlock_irq:
	.global L_8d0100
L_8d0100:
	mov_s r1,0x80
L_8d0102:
	mov_s r0,0x889800
L_8d0108:
	st.as r1,[r0,-0xe4]
L_8d010c:
	st.as r1,[r0,-0xdf]
L_8d0110:
	j_s [blink]
L_8d0112:
	nop_s
