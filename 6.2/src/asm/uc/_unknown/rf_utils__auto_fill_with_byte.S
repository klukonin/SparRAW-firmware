/* rf_utils__auto_fill_with_byte @ 0x92f160, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: brp__read_rf_id, brp__rf_module_done, brp_initiator_flow_successful_receive_training
 * Зовёт сам: rf_utils_auto_fill_uc
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global rf_utils__auto_fill_with_byte
rf_utils__auto_fill_with_byte:
	.global L_92f160
L_92f160:
	push_s blink
L_92f162:
	sub_s sp,sp,0x10
L_92f164:
	mov_s r3,r0
L_92f166:
	mov_s r2,0x801820
L_92f16c:
	ld r11,[r2]
L_92f170:
	mov r0,sp
L_92f174:
	ld r10,[r2, 0x4]
L_92f178:
	ld r9,[r2, 0x8]
L_92f17c:
	ld r8,[r2, 0xc]
L_92f180:
	st r11,[sp]
L_92f184:
	st r10,[sp, 0x4]
L_92f188:
	st r9,[sp, 0x8]
L_92f18c:
	st r8,[sp, 0xc]
L_92f190:
	bl.d L_92ed84
L_92f194:
	stb r3,[sp]
L_92f198:
	add_s sp,sp,0x10
L_92f19a:
	pop_s blink
L_92f19c:
	j_s [blink]
L_92f19e:
	nop_s
