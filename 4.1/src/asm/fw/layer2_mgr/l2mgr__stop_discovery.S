/* l2mgr__stop_discovery @ 0x8f33fc, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: wmi_handler_discovery_stop
 * Зовёт сам: __ld_r13_ret, l2mgr_mac_start_step, mid_list__by_mid, stop_find_session
 */
	.section .text.l2mgr__stop_discovery,"ax",@progbits
	.global l2mgr__stop_discovery
l2mgr__stop_discovery:
	.global L_8f33fc
L_8f33fc:
	push_s blink
L_8f33fe:
	bl.d L_8ca1b0
L_8f3402:
	push_s r13
L_8f3404:
	mov_s r13,r0
L_8f3406:
	bl.d L_8f17b8
L_8f340a:
	add r0,r0,0x234
L_8f340e:
	add3 r0,r13,0x9
L_8f3412:
	mov_s r1,0x80047c
L_8f3418:
	mov_s r3,0x8033dc
L_8f341e:
	add_s r2,r3,0x4
L_8f3420:
	ldw_s r3,[r3,0x26]
L_8f3422:
	bl.d L_8c43dc
L_8f3426:
	mov r4,0x1
L_8f342a:
	b L_8c033c
L_8f342e:
	nop_s
