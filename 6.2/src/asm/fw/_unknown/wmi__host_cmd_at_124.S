/* wmi__host_cmd_at_124 @ 0x8de364, 32 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: mlme_notify
 * Зовёт сам: __ld_r13_to_r13_ret, basic_sm__handle_event, conn_main_sm__start_disc
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi__host_cmd_at_124
wmi__host_cmd_at_124:
	.global L_8de364
L_8de364:
	push_s blink
L_8de366:
	push_s r13
L_8de368:
	bl.d L_8e7978
L_8de36c:
	mov_s r13,r0
L_8de36e:
	mov_s r0,r13
L_8de370:
	add r0,r0,0x124
L_8de374:
	mov_s r1,0x5
L_8de376:
	mov_s r2,0x0
L_8de378:
	mov_s r3,r2
L_8de37a:
	bl.d L_8d9b6c
L_8de37e:
	mov_s r4,r2
L_8de380:
	b L_8c025c
