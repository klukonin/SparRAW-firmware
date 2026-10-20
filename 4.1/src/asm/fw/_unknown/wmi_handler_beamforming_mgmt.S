/* wmi_handler_beamforming_mgmt @ 0x8d94b0, 140 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   START_0
 *   DONE_0
 *   START_1
 *   DONE_1
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, basic_if__alloc_mbox_slot, basic_if__post_event, fw_log__emit0, lmac_mbox__alloc_slot, send_cmd2_lmac
 */
	.section .text.wmi_handler_beamforming_mgmt,"ax",@progbits
	.global wmi_handler_beamforming_mgmt
wmi_handler_beamforming_mgmt:
	.global L_8d94b0
L_8d94b0:
	push_s blink
L_8d94b2:
	bl L_8c02b8
L_8d94b6:
	mov_s r16,r0
L_8d94b8:
	mov_s r14,r1
L_8d94ba:
	bl.d L_8c2b0c
L_8d94be:
	mov_s r15,r2
L_8d94c0:
	mov_s r13,r0
L_8d94c2:
	ld_s r0,[r14]
L_8d94c4:
	mov_s r2,0x100609c
L_8d94ca:
	st_s r0,[r13]
L_8d94cc:
	ld_s r0,[r14,0x4]
L_8d94ce:
	st_s r0,[r13,0x4]
L_8d94d0:
	ld_s r0,[r14,0x8]
L_8d94d2:
	st_s r0,[r13,0x8]
L_8d94d4:
	mov_s r0,0x0
L_8d94d6:
	bl.d L_8edfb0
L_8d94da:
	mov_s r1,r0
L_8d94dc:
	mov_s r0,r13
L_8d94de:
	mov_s r1,0x9
L_8d94e0:
	mov_s r2,0xc
L_8d94e2:
	bl.d L_8e0694
L_8d94e6:
	mov_s r3,r15
L_8d94e8:
	mov_s r2,0x10060a4
L_8d94ee:
	mov_s r0,0x0
L_8d94f0:
	bl.d L_8edfb0
L_8d94f4:
	mov_s r1,r0
L_8d94f6:
	bl.d L_8c2c38
L_8d94fa:
	mov_s r0,r16
L_8d94fc:
	mov_s r17,r0
L_8d94fe:
	mov_s r2,0x10060ac
L_8d9504:
	mov_s r0,0x0
L_8d9506:
	bl.d L_8edfb0
L_8d950a:
	mov_s r1,r0
L_8d950c:
	mov_s r0,r16
L_8d950e:
	mov_s r1,r17
L_8d9510:
	mov_s r2,0x0
L_8d9512:
	mov_s r3,0x1836
L_8d9518:
	mov r4,0x0
L_8d951c:
	mov_s r5,r15
L_8d951e:
	mov r6,0x0
L_8d9522:
	bl.d L_8e0460
L_8d9526:
	mov r7,0x0
L_8d952a:
	mov_s r2,0x10060b4
L_8d9530:
	mov_s r0,0x0
L_8d9532:
	bl.d L_8edfb0
L_8d9536:
	mov_s r1,r0
L_8d9538:
	b L_8c031c
