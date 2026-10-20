/* l2mgr__send_ba_status_evt @ 0x8e061c, 120 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_BA_STATUS_EVENTID for midid %d.
 * Зовут его: ba__report_and_resume, ba__send_status_from_rec, sw_vring__ba_agreed
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log__emit1, operational_if__alloc_evt, operational_if__send_evt
 */
	.section .text.l2mgr__send_ba_status_evt,"ax",@progbits
	.global l2mgr__send_ba_status_evt
l2mgr__send_ba_status_evt:
	.global L_8e061c
L_8e061c:
	push_s blink
L_8e061e:
	bl L_8c02b0
L_8e0622:
	mov_s r13,r0
L_8e0624:
	mov_s r15,r1
L_8e0626:
	mov_s r16,r2
L_8e0628:
	mov_s r17,r3
L_8e062a:
	mov r19,r4
L_8e062e:
	bl.d L_8c2b68
L_8e0632:
	mov r18,r5
L_8e0636:
	mov_s r14,r0
L_8e0638:
	stb r16,[r0]
L_8e063c:
	lsr r16,r16,0x8
L_8e0640:
	stb r16,[r0, 0x1]
L_8e0644:
	mov_s r0,0x0
L_8e0646:
	stb_s r0,[r14,0x2]
L_8e0648:
	stb_s r0,[r14,0x3]
L_8e064a:
	stb_s r15,[r14,0x4]
L_8e064c:
	stb r17,[r14, 0x5]
L_8e0650:
	stb r19,[r14, 0x6]
L_8e0654:
	lsr r19,r19,0x8
L_8e0658:
	stb r19,[r14, 0x7]
L_8e065c:
	stb r18,[r14, 0x8]
L_8e0660:
	ld_s r0,[r13]
L_8e0662:
	mov_s r2,0x100f010
L_8e0668:
	ld_s r3,[r0,0xc]
L_8e066a:
	mov_s r0,0xb
L_8e066c:
	mov_s r1,0x2
L_8e066e:
	bl.d L_8edfcc
L_8e0672:
	ldb_s r3,[r3,0x10]
L_8e0674:
	ld_s r0,[r13]
L_8e0676:
	mov_s r1,0x1823
L_8e067c:
	ld_s r3,[r0,0xc]
L_8e067e:
	mov_s r0,r14
L_8e0680:
	mov_s r2,0x9
L_8e0682:
	ldb_s r3,[r3,0x10]
L_8e0684:
	mov r4,0x0
L_8e0688:
	bl.d L_8e0874
L_8e068c:
	mov r5,r4
L_8e0690:
	b L_8c030c
