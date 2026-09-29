/* hwd_rfc_xpm_get_data_output @ 0x8d1300, 132 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hwd_rfc_xpm_get_data_output(): Timeout occured while waiting for valid data output. cur_iteration=%d, is_busy=%d, data_output_valid=%d,
 *   [NNL] rgf_val=0x%x
 * Зовут его: xpm__read_data_byte
 * Зовёт сам: __ld_r19_to_r13_ret, __st_r19_to_r13, fw_log__emit1, fw_log__emit3, hwd_rfc_read_rgf
 */
	.section .text.hwd_rfc_xpm_get_data_output,"ax",@progbits
	.global hwd_rfc_xpm_get_data_output
hwd_rfc_xpm_get_data_output:
	.global L_8d1300
L_8d1300:
	push_s blink
L_8d1302:
	bl L_8c02b0
L_8d1306:
	mov_s r19,r0
L_8d1308:
	mov_s r16,r1
L_8d130a:
	mov_s r18,r2
L_8d130c:
	mov_s r17,r3
L_8d130e:
	mov_s r13,0x0
L_8d1310:
	mov_s r14,r13
L_8d1312:
	mov_s r5,r13
L_8d1314:
	mov_s r4,r13
L_8d1316:
	mov_s r15,r13
	.global L_8d1318
L_8d1318:
	breq r18,0x0,L_8d1320
L_8d131c:
	brlo r17,r14,L_8d1350
	.global L_8d1320
L_8d1320:
	mov_s r0,r19
L_8d1322:
	bl.d L_8d04fc
L_8d1326:
	mov r1,0x3d0
L_8d132a:
	mov_s r13,r0
L_8d132c:
	mov_s r4,r0
L_8d132e:
	bic r4,r4,-0x401
L_8d1332:
	mov_s r5,r0
L_8d1334:
	bic r5,r5,-0x101
L_8d1338:
	mov_s r15,0x0
L_8d133a:
	bbit1 r0,0xa,L_8d1344
L_8d133e:
	btst_s r13,0x8
L_8d1340:
	mov.ne r15,0x1
	.global L_8d1344
L_8d1344:
	extb_s r15,r15
L_8d1346:
	/* add_s r14,0x1 */
	.byte 0x01,0xe6
L_8d1348:
	breq r18,0x0,L_8d1370
L_8d134c:
	breq_s r15,0,L_8d1318
L_8d134e:
	b_s L_8d1370
	.global L_8d1350
L_8d1350:
	mov_s r2,0x10196e4
L_8d1356:
	mov_s r0,0x0
L_8d1358:
	mov_s r1,r0
L_8d135a:
	bl.d L_8ee034
L_8d135e:
	mov_s r3,r14
L_8d1360:
	mov_s r2,0x101976c
L_8d1366:
	mov_s r0,0x0
L_8d1368:
	mov_s r1,r0
L_8d136a:
	bl.d L_8edfcc
L_8d136e:
	mov_s r3,r13
	.global L_8d1370
L_8d1370:
	breq_s r15,0,L_8d1378
L_8d1372:
	stb r13,[r16]
L_8d1376:
	b_s L_8d137e
	.global L_8d1378
L_8d1378:
	mov_s r1,0xff
L_8d137a:
	stb r1,[r16]
	.global L_8d137e
L_8d137e:
	b.d L_8c030c
L_8d1382:
	mov_s r0,r15
