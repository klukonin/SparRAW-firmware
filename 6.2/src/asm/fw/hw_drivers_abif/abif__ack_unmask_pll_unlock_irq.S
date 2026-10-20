/* abif__ack_unmask_pll_unlock_irq @ 0x8d0114, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwm__reset_analog_block
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, car__get_pll3_status_bit3, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global abif__ack_unmask_pll_unlock_irq
abif__ack_unmask_pll_unlock_irq:
	.global L_8d0114
L_8d0114:
	push_s blink
L_8d0116:
	bl L_8c01e4
L_8d011a:
	mov_s r14,0x4
L_8d011c:
	mov_s r13,0x889800
L_8d0122:
	st.as r14,[r13,-0xe4]
L_8d0126:
	bl L_8d0188
L_8d012a:
	brne r0,0x1,L_8d0136
	.global L_8d012e
L_8d012e:
	st.as r14,[r13,-0xdf]
L_8d0132:
	b L_8c0254
	.global L_8d0136
L_8d0136:
	mov_s r0,blink
L_8d0138:
	mov_s r1,0x1417
L_8d013e:
	bl L_8c9b28
L_8d0142:
	b_s L_8d012e
