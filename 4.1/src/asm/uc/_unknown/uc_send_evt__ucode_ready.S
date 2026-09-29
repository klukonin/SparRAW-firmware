/* uc_send_evt__ucode_ready @ 0x925b5c, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: uc_main_init
 * Зовёт сам: __ld_r13_ret_uc, basic_if__alloc_evt_slot, set_reg_886ddc_9259fc, uc_mailbox__init_rings, uc_send_event
 */
	.section .text.uc_send_evt__ucode_ready,"ax",@progbits
	.global uc_send_evt__ucode_ready
uc_send_evt__ucode_ready:
	.global L_925b5c
L_925b5c:
	push_s blink
L_925b5e:
	push_s r13
L_925b60:
	mov_s r13,0x801618
L_925b66:
	bl.d L_930fc4
L_925b6a:
	mov_s r0,r13
L_925b6c:
	bl L_9259fc
L_925b70:
	bl.d L_921930
L_925b74:
	mov_s r0,r13
L_925b76:
	mov_s r1,0x0
L_925b78:
	mov_s r2,r1
L_925b7a:
	bl.d L_925dd8
L_925b7e:
	mov_s r3,r1
L_925b80:
	b L_92028c
