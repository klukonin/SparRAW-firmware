/* wmi_get_ssid @ 0x8ec264, 84 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   <<---- [HOST EVENT] WMI_GET_SSID_EVENTID for devid %d.
 * Зовут его: wmi__host_cmd_dispatch
 * Зовёт сам: __ld_r15_to_r13_ret, __st_r15_to_r13, fw_log_emit1, mem_pool__alloc_locked, mid__copy_ssid, mid_list__by_mid_fw, wmi_evt__post
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global wmi_get_ssid
wmi_get_ssid:
	.global L_8ec264
L_8ec264:
	push_s blink
L_8ec266:
	bl L_8c01e0
L_8ec26a:
	sub_s sp,sp,0x4
L_8ec26c:
	mov_s r15,r0
L_8ec26e:
	mov_s r14,r1
L_8ec270:
	bl.d L_8c33d0
L_8ec274:
	mov_s r0,r1
L_8ec276:
	mov_s r13,r0
L_8ec278:
	bl.d L_8cc3dc
L_8ec27c:
	mov_s r0,r15
L_8ec27e:
	add_s r0,r0,0x48
L_8ec280:
	bl.d L_8ccc98
L_8ec284:
	add_s r1,r13,0x4
L_8ec286:
	st_s r0,[r13]
L_8ec288:
	mov_s r1,0x100dc0c
L_8ec28e:
	mov_s r0,0x2b
L_8ec290:
	bl.d L_8dcc10
L_8ec294:
	mov_s r2,r15
L_8ec296:
	mov_s r2,0x0
L_8ec298:
	st_s r2,[sp,0x0]
L_8ec29a:
	mov_s r0,r14
L_8ec29c:
	mov_s r1,r13
L_8ec29e:
	mov_s r3,0x1828
L_8ec2a4:
	mov r4,0x24
L_8ec2a8:
	mov_s r5,r2
L_8ec2aa:
	mov_s r6,r2
L_8ec2ac:
	bl.d L_8e4fc4
L_8ec2b0:
	mov_s r7,r2
L_8ec2b2:
	b.d L_8c024c
L_8ec2b6:
	add_s sp,sp,0x4
