/* sw_vring__setup_macq @ 0x8e5304, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: sw_vring__ba_agreed, vring__on_macq_delete_ntf, vring__wait_macq_delete
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, sw_vring__setup_ba_win, tx_macq__config_queue, tx_macq__config_queue_b
 */
	.section .text.sw_vring__setup_macq,"ax",@progbits
	.global sw_vring__setup_macq
sw_vring__setup_macq:
	.global L_8e5304
L_8e5304:
	push_s blink
L_8e5306:
	bl L_8c02b8
L_8e530a:
	mov_s r14,r0
L_8e530c:
	mov_s r17,r2
L_8e530e:
	mov_s r16,r3
L_8e5310:
	mov_s r13,r4
L_8e5312:
	mov_s r15,r5
L_8e5314:
	mov r4,r6
L_8e5318:
	ldw_s r2,[r0,0x4]
L_8e531a:
	stb_s r1,[r0,0x1]
L_8e531c:
	lsr_s r2,r2
L_8e531e:
	ldb_s r1,[r0,0x3]
L_8e5320:
	bmsk_s r2,r2,0x0
L_8e5322:
	bl.d L_8c6cdc
L_8e5326:
	ldb_s r3,[r0,0x5]
L_8e5328:
	bl.d L_8c29cc
L_8e532c:
	mov_s r0,r14
L_8e532e:
	mov_s r0,r14
L_8e5330:
	mov_s r1,r13
L_8e5332:
	mov_s r2,r17
L_8e5334:
	mov_s r3,r16
L_8e5336:
	bl.d L_8c3bcc
L_8e533a:
	mov_s r4,r15
L_8e533c:
	b L_8c031c
