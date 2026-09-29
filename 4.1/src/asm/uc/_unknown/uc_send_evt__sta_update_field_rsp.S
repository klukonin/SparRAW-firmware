/* uc_send_evt__sta_update_field_rsp @ 0x925d54, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ucode_cmd_install_key
 * Зовёт сам: basic_if__alloc_evt_slot, uc_send_event
 */
	.section .text.uc_send_evt__sta_update_field_rsp,"ax",@progbits
	.global uc_send_evt__sta_update_field_rsp
uc_send_evt__sta_update_field_rsp:
	.global L_925d54
L_925d54:
	sub_s sp,sp,0x8
L_925d56:
	push_s blink
L_925d58:
	st_s r0,[sp,0x4]
L_925d5a:
	mov_s r0,0x801618
L_925d60:
	bl.d L_921930
L_925d64:
	st_s r1,[sp,0x8]
L_925d66:
	ld_s r2,[sp,0x4]
L_925d68:
	ld_s r1,[sp,0x8]
L_925d6a:
	st_s r2,[r0]
L_925d6c:
	st_s r1,[r0,0x4]
L_925d6e:
	mov_s r1,0x11
L_925d70:
	mov_s r2,0x8
L_925d72:
	bl.d L_925dd8
L_925d76:
	mov_s r3,0x0
L_925d78:
	pop_s blink
L_925d7a:
	j_s.d [blink]
L_925d7c:
	add_s sp,sp,0x8
L_925d7e:
	nop_s
