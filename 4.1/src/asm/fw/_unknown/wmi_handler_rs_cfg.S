/* wmi_handler_rs_cfg @ 0x8d9718, 144 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   CID = %d
 *   RS ENABLE = %d
 *   <<---- [HOST EVENT] WMI_RS_CFG_DONE_EVENTID status=%d, cid=%d
 * Зовут его: host_if__wmi_cmd_dispatch
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, basic_if__alloc_mbox_slot, basic_if__post_event, fw_log__emit1, fw_log__emit2, lmac_if_send_cmd_0x13, memset0_words, rs_cfg__validate
 */
	.section .text.wmi_handler_rs_cfg,"ax",@progbits
	.global wmi_handler_rs_cfg
wmi_handler_rs_cfg:
	.global L_8d9718
L_8d9718:
	push_s blink
L_8d971a:
	bl L_8c02b8
L_8d971e:
	mov_s r16,r0
L_8d9720:
	mov_s r14,r1
L_8d9722:
	mov_s r17,r2
L_8d9724:
	mov_s r2,0x10060d4
L_8d972a:
	mov_s r0,0x5
L_8d972c:
	mov_s r1,0x2
L_8d972e:
	bl.d L_8edfcc
L_8d9732:
	ldb_s r3,[r14]
L_8d9734:
	mov_s r2,0x10063bc
L_8d973a:
	mov_s r0,0x5
L_8d973c:
	mov_s r1,0x2
L_8d973e:
	bl.d L_8edfcc
L_8d9742:
	ldb_s r3,[r14,0x1]
L_8d9744:
	mov_s r0,r16
L_8d9746:
	bl.d L_8d97a8
L_8d974a:
	mov_s r1,r14
L_8d974c:
	cmp_s r0,0x0
L_8d974e:
	mov_s r15,0x0
L_8d9750:
	mov.eq r15,0x1
L_8d9754:
	beq_s L_8d9760
L_8d9756:
	ldb_s r0,[r14]
L_8d9758:
	add_s r2,r14,0x2
L_8d975a:
	bl.d L_8d88b8
L_8d975e:
	ldb_s r1,[r14,0x1]
	.global L_8d9760
L_8d9760:
	bl.d L_8c2c38
L_8d9764:
	mov_s r0,r16
L_8d9766:
	mov_s r13,r0
L_8d9768:
	bl.d L_8c1a78
L_8d976c:
	mov_s r1,0x4
L_8d976e:
	stb_s r15,[r13,0x1]
L_8d9770:
	ldb r4,[r14]
L_8d9774:
	extb_s r3,r15
L_8d9776:
	stb r4,[r13]
L_8d977a:
	mov_s r2,0x10063cc
L_8d9780:
	mov_s r0,0x5
L_8d9782:
	bl.d L_8edff8
L_8d9786:
	mov_s r1,0x2
L_8d9788:
	mov_s r0,r16
L_8d978a:
	mov_s r1,r13
L_8d978c:
	mov_s r2,0x0
L_8d978e:
	mov_s r3,0x1921
L_8d9794:
	mov r4,0x4
L_8d9798:
	mov r5,r17
L_8d979c:
	mov_s r6,r2
L_8d979e:
	bl.d L_8e0460
L_8d97a2:
	mov_s r7,r2
L_8d97a4:
	b L_8c031c
