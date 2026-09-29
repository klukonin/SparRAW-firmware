/* l2mgr__send_disconnect_evt @ 0x8f051c, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_DISCONNECT_EVENTID wmi reason %d, protocol reason %d
 * Зовут его: host_if__connect_rf_kill, l2mgr__disconnect_done, l2mgr__disconnect_sta, wmi_handler_connect
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit2, get_g_8000ac_8c5c9c, memcpy_fw, operational_if__alloc_evt, operational_if__send_evt
 */
	.section .text.l2mgr__send_disconnect_evt,"ax",@progbits
	.global l2mgr__send_disconnect_evt
l2mgr__send_disconnect_evt:
	.global L_8f051c
L_8f051c:
	push_s blink
L_8f051e:
	bl L_8c02b8
L_8f0522:
	mov_s r17,r0
L_8f0524:
	mov_s r15,r1
L_8f0526:
	mov_s r14,r2
L_8f0528:
	bl.d L_8c2b68
L_8f052c:
	mov_s r16,r3
L_8f052e:
	mov_s r13,r0
L_8f0530:
	stw.ab r15,[r0,0x2]
L_8f0534:
	mov_s r1,r17
L_8f0536:
	bl.d L_8c0460
L_8f053a:
	mov_s r2,0x6
L_8f053c:
	brhs.d r14,0x9,L_8f0564
L_8f0540:
	mov_s r3,0x7
L_8f0542:
	ldb.x r14,[0x801ec0,r14]
L_8f054a:
	add r0,pcl,0xa
L_8f054e:
	add1_s r0,r0,r14
L_8f0550:
	j_s [r0]
L_8f0552:
	mov_s r3,0x3
L_8f0554:
	b_s L_8f0564
L_8f0556:
	mov_s r3,0x2
L_8f0558:
	b_s L_8f0564
L_8f055a:
	mov_s r3,0x4
L_8f055c:
	b_s L_8f0564
L_8f055e:
	mov_s r3,0xd
L_8f0560:
	b_s L_8f0564
L_8f0562:
	mov_s r3,0x6
	.global L_8f0564
L_8f0564:
	stb_s r3,[r13,0x8]
L_8f0566:
	mov_s r0,0x0
L_8f0568:
	stb_s r0,[r13,0x9]
L_8f056a:
	mov_s r2,0x100c338
L_8f0570:
	mov_s r0,0xb
L_8f0572:
	mov_s r1,0x2
L_8f0574:
	bl.d L_8edff8
L_8f0578:
	mov_s r4,r15
L_8f057a:
	mov_s r0,r13
L_8f057c:
	mov_s r1,0x3
L_8f057e:
	bset_s r1,r1,0xc
L_8f0580:
	mov_s r2,0xa
L_8f0582:
	mov_s r3,r16
L_8f0584:
	mov r4,0x0
L_8f0588:
	bl.d L_8e0874
L_8f058c:
	mov r5,r4
L_8f0590:
	bl.d L_8c5c9c
L_8f0594:
	mov_s r0,0x2
L_8f0596:
	bl.d L_8c5c9c
L_8f059a:
	mov_s r0,0x1
L_8f059c:
	b L_8c031c
