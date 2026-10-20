/* uc_send_evt__ps_wake_pcie @ 0x925d80, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: power_manager__maybe_wake_pcie
 * Зовёт сам: __ld_r13_ret_uc, basic_if__alloc_evt_slot, uc_send_event
 */
	.section .text.uc_send_evt__ps_wake_pcie,"ax",@progbits
	.global uc_send_evt__ps_wake_pcie
uc_send_evt__ps_wake_pcie:
	.global L_925d80
L_925d80:
	push_s blink
L_925d82:
	push_s r13
L_925d84:
	mov_s r13,r0
L_925d86:
	mov_s r0,0x801618
L_925d8c:
	bl L_921930
L_925d90:
	ldb r11,[r13]
L_925d94:
	mov_s r1,0x19
L_925d96:
	stb r11,[r0]
L_925d9a:
	mov_s r2,0x1
L_925d9c:
	bl.d L_925dd8
L_925da0:
	mov_s r3,0x0
L_925da2:
	b L_92028c
L_925da6:
	nop_s
